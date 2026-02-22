//
//  DiplomWork3_WeatherTests.swift
//  DiplomWork3 WeatherTests
//
//  Created by Apple on 20.02.26.
//
@testable import DiplomWork3_Weather
import XCTest

enum Results {
    static let radians: CGFloat = 1.5707963267948966
    static let coordinates: Coordinates = Coordinates(lat: 20, lon: 20)
}

final class PresenterTest: XCTestCase {

    var sut: Presenter!
    
    var testedArray = [CityNames]()
    private var networkServiceMock: NetworkServiceMock!
    private var saverMock: SafeLoadManagerMock!
    
    override func setUp() {
        super.setUp()
        networkServiceMock = NetworkServiceMock()
        saverMock = SafeLoadManagerMock()
        sut = Presenter(network: networkServiceMock, saver: saverMock)
    }
   
    override func tearDown() {
        networkServiceMock = nil
        sut = nil
        saverMock = nil
        super.tearDown()
    }
    
    func test_cityRequest(){
        sut.cityRequest()
        
        XCTAssertTrue(networkServiceMock.invokedGetCoordinates, "done")
        XCTAssertEqual(networkServiceMock.invokedGetCoordinatesCount, 1, "done")
    }
    
    func test_findCityRequest(){
        let city = "Brest"
        sut.findCityRequest(city: city)
        
        XCTAssertTrue(networkServiceMock.invokedFindCityRequest)
        XCTAssertEqual(networkServiceMock.invokedFindCityRequestCount, 1)
        XCTAssertEqual(networkServiceMock.someCity, city)
    }
    
    func test_windDirectionRadians(){
        let degrees = 90
        
        let result = sut.windDirectionRadians(direction: degrees)
        
        XCTAssertEqual(result, Results.radians)
        
    }
    
    func test_addObjectCityToArray(){
        let object = CityNames(name: "Diamond", lat: 10, lon: 10, country: "OZ", localNames: "Diamond")
        sut.addObjectCityTiArray(object: object)
        
        XCTAssertTrue(saverMock.addedAndSaved)
        XCTAssertEqual(saverMock.count, 1)
        XCTAssertEqual(saverMock.savedMockArray?.last?.name, object.name)
    }
    
    func test_loadData(){
        sut.loadData()
        
        XCTAssertEqual(saverMock.savedMockArray?.count, 1)
        XCTAssertTrue(saverMock.addedAndSaved)
        XCTAssertEqual(saverMock.count, 1)
    }
    
    func test_cityRequestFromTableViewByCoordinates(){
        sut.cityRequestFromTableViewByCoordinates(coordinates: Results.coordinates)
        
        XCTAssertEqual(networkServiceMock.invokedCoordinatesCityRequestCount, 1)
        XCTAssertTrue(networkServiceMock.invokedCoordinatesCityRequest)
        XCTAssertTrue(networkServiceMock.invokedCoordinatesBool)
    }

}
