# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
                {document_id: '73188738', name: 'David', last_name: 'Jimenez', email: 'jimenez.vasquez.david@gmail.com', password: 'arquitectura'},
                {document_id: '12345678', name: 'Sergio', last_name: 'Rios', email: 'srios11@gmail.com', password: 'arquitectura'},
                {document_id: '23456789', name: 'David', last_name: 'Espinal', email: 'despinalr@gmail.com', password: 'arquitectura'},
                {document_id: '34567890', name: 'Felipe', last_name: 'Mendivelso', email: 'lfmendivelso@gmail.com', password: 'arquitectura'}
            ])

Pet.create([
    {name: 'Terry', breed: 'Chow Chow', birthday: '20-03-03', characteristics: '', contact: '', user: User.find_by(document_id: '73188738')},
    {name: 'Andy', breed: 'Criollo', birthday: '31-03-03', characteristics: '', contact: '', user: User.find_by(document_id: '73188738')}
])

#SafeZone.create([
#    {coorX1: 1, coorX2: 2, coorY1: 1, coorY2: 3, pet: Pet.find_by(name: 'Terry')},
#    {coorX1: 10, coorX2: 20, coorY1: 10, coorY2: 30, pet: Pet.find_by(name: 'Terry')}
#    ])

#Collar.create([
#    {collar_id: '1', pet_id: Pet.find_by(name: 'Terry')}, 
#    {collar_id: '2', pet_id: Pet.find_by(name: 'Andy')}
#    ])
    
    
    