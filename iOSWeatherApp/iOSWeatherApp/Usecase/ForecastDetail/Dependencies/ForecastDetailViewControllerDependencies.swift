import CoreLocation

extension ForecastDetailViewController {
    override func injectDependencies() {
        let provider = ImagefetcherGateway()
        let viewModel = ConcreteForecastDetailViewModel(delegate: self)
        imagefetcher = Imagefetcher(delegate: viewModel, provider: provider)
    }
}
