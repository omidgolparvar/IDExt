//
//  IDLogin.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/19/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PersianSwift

public class IDJoin {
	
	public weak var delegate			: IDJoinDelegate?	= nil
	
	public var currentStep				: JoinStep			= .submitMobile
	public var mobileNumber				: String			= ""
	public var oneTimeCode				: String			= ""
	public var mobileSubmitDate			: Date				= Date()
	public var minimumRetryInterval		: Int				= 120
	
	public var canResendOneTimeCode		: Bool {
		return Calendar.current.dateComponents([.second], from: mobileSubmitDate, to: Date()).second! > minimumRetryInterval
	}
	
	public init(delegate: IDJoinDelegate) {
		self.delegate = delegate
	}
	
	public func validateAndSet(mobileNumber: String) throws {
		let _mobileNumber = mobileNumber.id_Trimmed
		guard !_mobileNumber.isEmpty else { throw ValidationError.mobileIsEmpty }
		guard _mobileNumber.ps.isPersianPhoneNumber else { throw ValidationError.mobileIsInvalid }
		self.mobileNumber = _mobileNumber
	}
	
	public func validateAndSet(oneTimeCode: String) throws {
		let _oneTimeCode = oneTimeCode.id_Trimmed
		guard !_oneTimeCode.isEmpty else { throw ValidationError.tokenIsEmpty }
		self.oneTimeCode = _oneTimeCode
	}
	
	public func reset() {
		currentStep		= .submitMobile
		mobileNumber	= ""
		oneTimeCode		= ""
	}
	
	public func submitMobile() {
		guard let submitMobileEndpoint = delegate?.idJoin_SubmitMobileEndpoint(self) else { return }
		IDMoya.Perform(submitMobileEndpoint) { [weak self] (result, data) in
			guard let _self = self else { return }
			_self.mobileSubmitDate = .ID_Now
			_self.delegate?.idJoin_DidSubmitMobile(_self, withResult: result, andData: data)
		}
	}
	
	public func submitOneTimeCode() {
		guard let submitOneTimeCodeEndpoint = delegate?.idJoin_SubmitOneTimeCodeEndpoint(self) else { return }
		IDMoya.Perform(submitOneTimeCodeEndpoint) { [weak self] (result, data) in
			guard let _self = self else { return }
			_self.delegate?.idJoin_DidSubmitOneTimeCode(_self, withResult: result, andData: data)
		}
	}
	
	public func resendOneTimeCode() {
		submitMobile()
	}
	
	public enum JoinStep {
		case submitMobile
		case submitToken
	}
	
	public enum ValidationError: Error {
		case errors([ValidationError])
		
		case mobileIsEmpty
		case mobileIsInvalid
		case tokenIsEmpty
		
		public var localizedDescription: String {
			switch self {
			case .mobileIsEmpty		: return "شماره همراه وارد نشده است"
			case .mobileIsInvalid		: return "شماره همراه وارد شده، معتبر نیست"
			case .tokenIsEmpty		: return "کد تایید وارد نشده است"
			case .errors(let all)	: return all.map { $0.localizedDescription }.joined(separator: "\n")
			}
		}
		
		
	}
	
}

