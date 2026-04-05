import UIKit
import RxSwift
import RxCocoa

// MARK: - Refresh Header

/// 下拉刷新头部视图
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
        refreshControl.tintColor = .bd_pink
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
            .filter { $0 }
            .map { _ in () }
            .bind(to: loadMoreSubject)
            .disposed(by: disposeBag)
    }

    public func endLoading() {
        isLoading = false
    }
}
