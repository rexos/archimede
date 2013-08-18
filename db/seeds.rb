# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Delete all
#Teacher.delete_all
#Student.delete_all
Subject.delete_all

# Add subjects
Subject.create(name: 'Italiano')
Subject.create(name: 'Storia')
Subject.create(name: 'Latino')
Subject.create(name: 'Greco')
Subject.create(name: 'Matematica')
Subject.create(name: 'Fisica')
Subject.create(name: 'Scienze naturali, chimica e geografia')
Subject.create(name: 'Filosofia')
Subject.create(name: 'Storia dell\'Arte')
Subject.create(name: 'Lingua Inglese')
Subject.create(name: 'Lingua Tedesca')
Subject.create(name: 'Lingua Spagnola')
Subject.create(name: 'Lingua Francese')

=begin
# Add a teacher
t1 = Teacher.create(
:name => "Giovanni",
:last_name => "Pedrotti",
:password => "qwerty00",
:password_confirmation => 'qwerty00',
:email => "teacher@teacher.it",
:phone => "3389878066",
:skype => "pedro_bullo",
:skype_bool => true,
:cost => "20",
:range => 30,
:availability_days => "lunedi, martedi, mercoledi",
:info => "Sono bello e marachello",
:rating_bool => true,
:time_bank_bool => true,
:bill_bool => false
)

# Addresses
a1 = Address.create(:street => "Via Bernardo Clesio", :number => 5, :cap => 38122, :city => "Trento", :province => "TN", :country => "Italia")
a2 = Address.create(:street => "Via Giovanni Segantini", :number => 16, :cap => 38122, :city => "Trento", :province => "TN", :country => "Italia")
a3 = Address.create(:street => "Via Antonio Rosmini", :number => 1, :cap => 38122, :city => "Trento", :province => "TN", :country => "Italia")
a4 = Address.create(:street => "Via S. Croce", :number => 15, :cap => 38122, :city => "Trento", :province => "TN", :country => "Italia")
a5 = Address.create(:street => "Via Sommarive", :number => 5, :cap => 38123, :city => "Povo", :province => "TN", :country => "Italia")

# Add subjects and address to teacher
t1.subjects = Subject.all.sample(3)
t1.address = a1

# Add a student
s1 = Student.create(
:name => "Michele",
:last_name => "Rossi",
:password => "qwerty00",
:password_confirmation => "qwerty00",
:email => "student@student.it",
)

s1.address = a1

# Add admin
admin = Student.create(
:name => "Dio",
:last_name => "God",
:password => "qwerty00",
:password_confirmation => "qwerty00",
:email => "admin@admin.it",
:admin => true
)
=end
