//
//  PokemonAPI.swift
//  PokedexSprint
//
//  Created by Jorge Alvarez on 3/27/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

@objc class PokemonAPI: NSObject {

    @objc (sharedController) static let shared = PokemonAPI()

    @objc func fetchAllPokemon(completion: @escaping ([JLAPokemon]?, Error?) -> Void) {
        
        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
                
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                print("ERROR: \(error)")
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                print("no data")
                return
            }
                    
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = dictionary["results"] as! [[String: Any]] // array of array of dictionaries
                let pokemonResults = results.map {JLAPokemon(dictionary: $0)}
                completion(pokemonResults, nil) //
            } catch {
                print("DECODE error: \(error)")
                completion(nil, NSError())
                return
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: JLAPokemon) {
                
        var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        baseURL = baseURL.appendingPathComponent(pokemon.name)
                
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let fetchedPokemon = JLAPokemon(dictionary: dictionary)
                
                pokemon.name = fetchedPokemon.name
                pokemon.identifier = fetchedPokemon.identifier
                pokemon.sprite = fetchedPokemon.sprite
                pokemon.abilities = fetchedPokemon.abilities
                                
            } catch {
                print("DECODE error: \(error)")
                return
            }
        }.resume()
    }
}
