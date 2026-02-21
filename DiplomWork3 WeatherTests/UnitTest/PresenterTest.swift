//
//  DiplomWork3_WeatherTests.swift
//  DiplomWork3 WeatherTests
//
//  Created by Apple on 20.02.26.
//
@testable import DiplomWork3_Weather
import XCTest


final class PresenterTest: XCTestCase {

    var sut: Presenter!
    
    private var networkServiceMock: NetworkServiceMock!
    
    override func setUp() {
        super.setUp()
        networkServiceMock = NetworkServiceMock()
        sut = Presenter(network: networkServiceMock)
    }
   
    override func tearDown() {
        networkServiceMock = nil
        sut = nil
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
    
//    func test_windDirectionRadians(){
//        let degrees = 90
//        
//        sut.windDirectionRadians(direction: degrees)
//        
//        XCTAssertEqual(test, Expected.radians)
//        
//    }

}
