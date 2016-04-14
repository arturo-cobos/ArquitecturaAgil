# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Owner.create([
    {document_id: '73188738', name: 'David', last_name: 'Jimenez', email: 'jimenez.vasquez.david@gmail.com', phone: '3813000', cellphone: '3152776990'},
    {document_id: '12345678', name: 'Sergio', last_name: 'Rios', email: 'srios11@gmail.com', phone: '4789855', cellphone: '301485983'},
    {document_id: '23456789', name: 'David', last_name: 'Espinal', email: 'despinalr@gmail.com', phone: '6784125', cellphone: '3154772598'},
    {document_id: '34567890', name: 'Felipe', last_name: 'Mendivelso', email: 'lfmendivelso@gmail.com', phone: '3457897', cellphone: '3111237894'}
])
            
PetType.create([
    {name: 'Perro', description: ''},
    {name: 'Gato', description: ''}
])

PetStatus.create([
    {name: 'Estado1', description: ''},
    {name: 'Estado2', description: ''}
])

Pet.create([
    {owner: Owner.find_by(document_id: '73188738'), name: 'Terry', pet_type: PetType.find_by(name: 'Perro'), pet_status: PetStatus.find_by(name: 'Estado1'), gender: 'M', description: ''},
    {owner: Owner.find_by(document_id: '73188738'), name: 'Andy', pet_type: PetType.find_by(name: 'Perro'), pet_status: PetStatus.find_by(name: 'Estado1'), gender: 'M', description: ''},
    {owner: Owner.find_by(document_id: '73188738'), name: 'Negrita', pet_type: PetType.find_by(name: 'Gato'), pet_status: PetStatus.find_by(name: 'Estado1'), gender: 'F', description: ''},
])

SafeZone.create([
    {pet: Pet.find_by(name: 'Terry'), latitude: 40.23, longitude: 50.45, radium: 10.3},
    {pet: Pet.find_by(name: 'Terry'), latitude: 87.23, longitude: 10.235, radium: 27.3},
    {pet: Pet.find_by(name: 'Andy'), latitude: 97.37779, longitude: 18.57773, radium: 37.7},
    ])

Collar.create([
    {pet: Pet.find_by(name: 'Terry'), reference: '', description: ''}, 
    {pet: Pet.find_by(name: 'Andy'), reference: '', description: ''}, 
    {pet: Pet.find_by(name: 'Negrita'), reference: '', description: ''}, 
    ])
    
    
    