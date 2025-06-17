//
//  ResolverInjected.swift
//  eTrip
//
//  Created by k41ed on 22/12/2024.
//
import Resolver

@propertyWrapper
public struct Injected<T> {
    public var wrappedValue: T
    
    public init() {
        self.wrappedValue = Resolver.resolve()
    }
}
