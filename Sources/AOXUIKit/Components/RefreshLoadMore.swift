import UIKit
import RxSwift
import RxCocoa

// MARK: - Refresh Header

/// 下拉刷新头部视图
@MainActor
public final class RefreshHeader {
    private weak var scrollView: UIScrollView?
    private let refreshSubject = PublishSubject<Void>()
    private let refreshControl: UIRefreshControl
    private let disposeBag = DisposeBag()

    /// 刷新事件 Observable
    public var rx_refresh: Observable<Void> { refreshSubject.asObservable() }

    public init(scrollView: UIScrollView) {
        self.refreshControl = UIRefreshControl()
        self.scrollView = scrollView
        refreshControl.tintColor = .aox_tint
        scrollView.refreshControl = refreshControl

        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: refreshSubject)
            .disposed(by: disposeBag)
    }

    /// 结束刷新
    public func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

// MARK: - Load More Footer

/// 上拉加载更多检测
@MainActor
public final class LoadMoreFooter {
    private let loadMoreSubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    private var isLoading = false

    /// 加载更多事件 Observable
    public var rx_loadMore: Observable<Void> { loadMoreSubject.asObservable() }

    public init(scrollView: UIScrollView, threshold: CGFloat = 100) {
        scrollView.rx.contentOffset
            .map { [weak scrollView] offset -> Bool in
                guard let scrollView else { return false }
                let contentHeight = scrollView.contentSize.height
                let frameHeight = scrollView.frame.height
                // 使用 adjustedContentInset 计算真实可滚动范围，
                // 避免 contentInsetAdjustmentBehavior = .always 时 contentSize < frameHeight
                // 但实际内容已超出可见区域的情况导致永远不触发加载更多。
                let maxOffset = contentHeight + scrollView.adjustedContentInset.bottom - frameHeight
                return maxOffset > 0 && offset.y > maxOffset - threshold
            }
            .distinctUntilChanged()
            // 进入加载中就置位并放行一次；未调用 endLoading() 前不再重复触发，
            // 避免同一次加载在到达底部区间内被多次触发（旧实现 isLoading 从未被置位，形同虚设）。
            .filter { [weak self] shouldLoad -> Bool in
                guard let self, shouldLoad, !self.isLoading else { return false }
                self.isLoading = true
                return true
            }
            .map { _ in () }
            .bind(to: loadMoreSubject)
            .disposed(by: disposeBag)
    }

    /// 加载完成后调用，允许下一次上拉加载触发
    public func endLoading() {
        isLoading = false
    }
}
