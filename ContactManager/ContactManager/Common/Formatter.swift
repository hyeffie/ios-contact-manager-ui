//
//  Formatter.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

protocol InputFormattable {
    func format(_ input: String) -> String
}

struct NameFormatter: InputFormattable {
    func format(_ input: String) -> String {
        var formattedName = input
        if input.contains(where: { $0 == " " }) {
            formattedName = removeBlank(from: input)
        }
        return formattedName
    }
    
    private func removeBlank(from input: String) -> String {
        return input.components(separatedBy: " ").reduce("") { $0 + $1 }
    }
}

struct AgeFormatter: InputFormattable {
    func format(_ input: String) -> String {
        var formattedAge = input
        
        if input.first == "0" {
            formattedAge = String(input.dropFirst())
        } else if input.count >= 2 {
            formattedAge = String(input.prefix(2))
        }
        
        return formattedAge
    }
}

struct PhoneNumberFormatter: InputFormattable {
    func format(_ input: String) -> String {
        let formattedText: String
        if input.first != "0" {
            formattedText = format(with: "XX-XXX-XXXX", phone: input)
        } else {
            formattedText = format(with: "XXX-XXXX-XXXX", phone: input)
        }
        return formattedText
    }
    
    private func format(with mask: String, phone: String) -> String {
        let numbers = phone.filter { ch in ch.isNumber }
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

struct ContactFormatterConfigure {
    let nameFormatter: InputFormattable
    let ageFormatter: InputFormattable
    let phoneNumberFormatter: InputFormattable
}
