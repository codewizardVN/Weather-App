import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel:WeatherViewModel
    @State private var city = ""
    
    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Weather App")
                    .font(.largeTitle.bold())
                
                TextField("Enter city", text: $city)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.search)
                    .onSubmit {
                        Task {
                            await viewModel.loadWeather(for: city)
                        }
                    }
                
                Button("Load Weather") {
                    Task {
                        await viewModel.loadWeather(for: city)
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
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
                    Text("Enter a city and load weather.")
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
