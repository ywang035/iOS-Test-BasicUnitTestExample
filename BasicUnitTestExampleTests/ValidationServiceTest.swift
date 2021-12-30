//
//  ValidationServiceTest.swift
//  BasicUnitTestExampleTests
//
//  Created by Yang W on 30/12/2021.
//

import XCTest
@testable import BasicUnitTestExample

class ValidationServiceTest: XCTestCase {
    
    var validationService: ValidationService!
    
    override func setUp() {
        super.setUp()
        validationService = ValidationService()
    }
    
    override func tearDown() {
        super.tearDown()
        validationService = nil
    }
    
    // MARK: - test cases for username
    func test_username_is_valid() throws {
        XCTAssertNoThrow(try validationService.validateUsername("joewang"))
    }
    
    func test_username_is_nil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validationService.validateUsername(nil)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_username_is_too_short() throws {
        let expectedError = ValidationError.usernameTooShort
        var error: ValidationError?
        let username = "joe"
        
        XCTAssertThrowsError(try validationService.validateUsername(username)) { throwError in
            error = throwError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_username_is_too_long() throws {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        let username = "joejoejoejoejoejoejoejoe"
        
        XCTAssertThrowsError(try validationService.validateUsername(username)) { throwError in
            error = throwError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    // MARK: - test cases for password
    func test_password_is_valid() throws {
        XCTAssertNoThrow(try validationService.validatePassword("1234567"))
    }
    
    
    func test_password_is_nil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validationService.validatePassword(nil)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    
    func test_password_is_too_short() throws {
        let expectedError = ValidationError.passwordTooShort
        var error: ValidationError?
        let password = "123"
        
        XCTAssertThrowsError(try validationService.validatePassword(password)) { throwError in
            error = throwError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    
    func test_password_is_too_long() throws {
        let expectedError = ValidationError.passwordTooLong
        var error: ValidationError?
        let password = "12345678901234567890"
        
        XCTAssertThrowsError(try validationService.validatePassword(password)) { throwError in
            error = throwError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }

}
