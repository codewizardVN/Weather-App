import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel(
        fetchWeatherUseCase: FetchWeatherUseCase(
            repository: WeatherRepository(
                remoteDataSource: WeatherRemoteDataSource()
            )
        )
    )

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Weather App")
                    .font(.largeTitle.bold())

                Text("Architecture skeleton is ready. You can now replace each placeholder with your own implementation.")
                    .foregroundStyle(.secondary)

                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let weather = viewModel.weather {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(weather.cityName)
                            .font(.title2.weight(.semibold))
                        Text("\(weather.temperature, specifier: "%.1f")°C")
                        Text(weather.conditionDescription)
                            .foregroundStyle(.secondary)
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                } else {
                    Text("No weather loaded yet.")
                        .foregroundStyle(.secondary)
                }

                Button("Load Sample Weather") {
                    Task {
                        await viewModel.loadWeather()
                    }
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
