//
//  Data+.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 18/6/25.
//
import Foundation

public extension Data {
    func toString(encoding: String.Encoding = .utf8) -> String? {
        String(data: self, encoding: encoding)
    }
    
    func toModel<D>(_ type: D.Type, using decoder: JSONDecoder? = nil) -> D? where D: Decodable {
        do {
            let decoder = decoder ?? JSONDecoder()
            return try decoder.decode(type, from: self)
        } catch {
//            log.error(error)
        }
        return nil
    }
    
    func toDictionary() -> [String: Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: self)
            return json as? [String: Any]
        } catch {
//            log.error(error)
        }
        return nil
    }

    func toDataPrettyPrinted() -> Self {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: self)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return self // fallback to original data if it can't be serialized.
        }
    }
    
    func logInfo(
        filename: String = #file,
        line: Int = #line,
        funcName: String = #function
    ) {
//        toJson().logInfo(filename: filename, line: line, funcName: funcName)
    }
    
    func getContent() -> Self {
        return self.toData(keyPath: "content")
    }
    
    func getPageInfo() -> Self {
        
        return self.toData(keyPath: "pageable")
    }
    
#if os(iOS)
    func toData(keyPath: String? = nil) -> Self {
        guard let keyPath = keyPath else {
            return self
        }
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            if let nestedJson = (json as AnyObject).value(forKeyPath: keyPath) {
                guard JSONSerialization.isValidJSONObject(nestedJson) else {
                    return self
                }
                let data = try JSONSerialization.data(withJSONObject: nestedJson)
                return data
            }
        } catch {
            return self
        }
        return self
    }
#endif
}
