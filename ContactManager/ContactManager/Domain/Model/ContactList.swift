//
//  ContactList.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

final class ContactList {
    typealias Index = Int
    
    private var contacts: [Contact]
    
    init(contacts: [Contact] = []) {
        self.contacts = contacts
    }
    
    func getContacts() -> [Contact] {
        return self.contacts
    }
    
    func addContact(_ newContact: Contact) -> [Contact] {
        self.contacts.append(newContact)
        return self.contacts
    }
    
    func deleteContact(at index: Index) throws -> [Contact] {
        guard validateIndex(index) else { throw ContactListError.invalidIndex }
        self.contacts.remove(at: index)
        return self.contacts
    }
    
    func updateContact(at index: Index, with newContact: Contact) throws -> [Contact] {
        guard validateIndex(index) else { throw ContactListError.invalidIndex }
        self.contacts[index] = newContact
        return self.contacts
    }
}

extension ContactList {
    private func validateIndex(_ index: Index) -> Bool {
        return self.contacts.indices.contains(index)
    }
}
