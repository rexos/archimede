# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Teacher.delete_all
Teacher.create(
:name => "Giovanni",
:last_name => "Pedrotti",
:password => 'qwerty77',
:password_confirmation => 'qwerty77',
:email => "pedro@fuego.com",
:phone => "3389878066",
:skype => "pedro_bullo",
:skype_bool => true,
:cost => "20",
:range => 30,
:availability_days => "lunedi, martedi, mercoledi",
:info => "Sono bello e marachello",
:rating_bool => true,
:time_bank_bool => true,
:bill_bool => true)

Subject.delete_all
Subject.create(name: 'Italiano')
Subject.create(name: 'Storia')
Subject.create(name: 'Latino')
Subject.create(name: 'Greco')
Subject.create(name: 'Matematica')
Subject.create(name: 'Fisica')
Subject.create(name: 'Scienze naturali, chimica e geografia')
Subject.create(name: 'Filosofia')
Subject.create(name: 'Storia dell\'Arte')
