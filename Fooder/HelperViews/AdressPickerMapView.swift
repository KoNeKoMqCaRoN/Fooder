//
//  AdressPickerMapView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/03.
//

import SwiftUI
import MapKit

// .onChangeで CLLocationCoordinate2D 使えるようにする
extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct AdressPickerMapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    @State var userPinnedLocation: CLLocationCoordinate2D? = nil

    @Binding var adress: String
    @Binding var lat: Double
    @Binding var lng: Double
    
    var body: some View {
        MapReader { reader in
            Map(position: $cameraPosition) {
                if let userPinnedLocation = userPinnedLocation {
                    Marker("ここ", coordinate: userPinnedLocation)
                }
            }
            .task {
                userPinnedLocation = await getCoordinates(from: adress)
                moveCameraPositionToPin()
            }
            .onTapGesture { screenCoord in
                if let pinLocation = reader.convert(screenCoord, from: .local) {
                    withAnimation {
                        userPinnedLocation = pinLocation
                    }
                    Task {
                        await adress = getAdressString(from: pinLocation)
                        moveCameraPositionToPin()
                    }
                }
            }
        }
        .onChange(of: userPinnedLocation, { _, coordinate in
            // Pinの場所が変わったら更新
            if let coordinate = coordinate {
                lat = coordinate.latitude
                lng = coordinate.longitude
            }
        })
        
        .overlay(alignment: .top) {
            TextField("例: 東京都渋谷区渋谷3-12-1", text: $adress)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.thickMaterial)
                .cornerRadius(10)
                .overlay(alignment: .trailing) {
                    if !adress.isEmpty {
                        Button {
                            adress = ""
                        } label: {
                            Image(systemName: "x.circle")
                        }
                        .foregroundStyle(.red)
                        .padding()
                    }
                }
                .padding()
                .onSubmit {
                    Task {
                        self.userPinnedLocation = await getCoordinates(from: adress)
                        moveCameraPositionToPin()
                    }
                }
        }
        
    }
    
    
    private func getCoordinates(from adress: String) async -> CLLocationCoordinate2D? {
        var coordinate: CLLocationCoordinate2D?
        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.geocodeAddressString(adress)
            if let placemark = placemarks.first {
                if let coord = placemark.location?.coordinate {
                    coordinate = coord
                }
            }
        } catch {
            print("経度、緯度取得に失敗しました。\(error.localizedDescription)")
        }
       
        return coordinate
    }
    
    
    private func getAdressString(from location: CLLocationCoordinate2D) async -> String {
        var adressString: String = ""
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                var addressComponents: [String] = []
                
                // 都道府県
                if let administrativeArea = placemark.administrativeArea {
                    addressComponents.append(administrativeArea)
                }

                // 市区町村
                if let locality = placemark.locality {
                    addressComponents.append(locality)
                }

                // 区（東京23区など）
                if let subAdministrativeArea = placemark.subAdministrativeArea {
                    addressComponents.append(subAdministrativeArea)
                }

                // 丁目・番地・号（重要：詳細住所用）
                if let thoroughfare = placemark.thoroughfare {
                    addressComponents.append(thoroughfare)
                }

                // 建物名・部屋番号など
                if let subThoroughfare = placemark.subThoroughfare {
                    addressComponents.append(subThoroughfare)
                }
                
                adressString = addressComponents.joined(separator: "")
            }
        } catch {
            print("住所取得に失敗しました。: \(error.localizedDescription)")
        }
        return adressString
    }
    
    private func moveCameraPositionToPin() {
        if let userPinnedLocation = userPinnedLocation {
            withAnimation {
                self.cameraPosition = .region(MKCoordinateRegion(center: userPinnedLocation, span: .init(latitudeDelta: 0.001, longitudeDelta: 0.001)))
            }
        }
    }
}

#Preview {
    @Previewable
    @State var lat: Double = 0
    @Previewable
    @State var lng: Double = 0
    @Previewable
    @State var adress: String = ""
    AdressPickerMapView(adress: $adress, lat: $lat, lng: $lng)
}
