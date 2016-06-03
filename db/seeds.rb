#---------------category
category_sc_fic = Category.create(title: "Science Fiction")
category_novel = Category.create(title: "Novels")
category_adventures = Category.create(title: "Adventures")
category_history = Category.create(title: "History")


biography = 'A biography (or simply bio) is a detailed description of a person`s life. It involves more than just the basic facts like education, work, relationships, and death, but also portrays a subject`s experience of these life events. Unlike a profile or curriculum vitae (résumé), a biography presents a subject`s life story, highlighting various aspects of his or her life, including intimate details of experience, and may include an analysis of the subject`s personality.'

#---------------authors
author_01 = Author.create(first_name: "Raymond Douglas", last_name: "Bradbury", biography: biography)
author_02 = Author.create(first_name: "Stephen Edwin", last_name: "King", biography: biography)
author_03 = Author.create(first_name: "Terence David John", last_name: "Pratchett", biography: biography)
author_04 = Author.create(first_name: "George Raymond Richard", last_name: "Martin", biography: biography)
author_05 = Author.create(first_name: "Mikhail", last_name: "Bulgakov", biography: biography)


description = 'is one of four rhetorical modes (also known as modes of discourse), along with exposition, argumentation, and narration. Each of the rhetorical modes is present in a variety of forms and each has its own purpose and conventions. The act of description may be related to that of definition. Description is also the fiction-writing mode for transmitting a mental image of the particulars of a story.[citation needed] Definition: The pattern of development that presents a word picture of a thing, a person, a situation, or a series of events.'

book_01 = Book.create(title: "Fahrenheit 451", price: 14.35, quantity: 30, author_id: author_01.id, description: description, category_id: category_sc_fic.id, bought: 0)
book_02 = Book.create(title: "The Green Mile", price: 11.40, quantity: 25, author_id: author_02.id, description: description, category_id: category_sc_fic.id, bought: 0)
book_03 = Book.create(title: "Small Gods", price: 10.35, quantity: 26, author_id: author_03.id, description: description, category_id: category_sc_fic.id, bought: 0)
book_04 = Book.create(title: "A Clash of Kings", price: 17.35, quantity: 37, author_id: author_04.id, description: description, category_id: category_sc_fic.id, bought: 0)
#book_05 = Book.create(title: "The Master and Margarita", price: 25.00, quantity: 31, description: description, category_id: category_sc_fic.id)

#---------------novel
#book_11 = Book.create(title: "A Thousand Splendid Suns", price: 12, quantity:28, category_id: category_novel.id, description: description)
#book_12 = Book.create(title: "Gone with the Wind", price: 15.00, quantity: 70, category_id: category_novel.id, description: description)
#book_13 = Book.create(title: "Pride and Prejudice", price: 17.35, quantity: 17, category_id: category_novel.id, description: description)
#book_14 = Book.create(title: "The Reader", price: 7.35, quantity: 45, category_id: category_novel.id, description: description)
#book_15 = Book.create(title: "The Thorn Birds", price: 19.00, quantity: 12, category_id: category_novel.id, description: description)

#---------------adventures
#book_21 = Book.create(title: "White Bim Black Ear", price: 8.85, quantity: 57, category_id: category_adventures.id, description: description)
#book_22 = Book.create(title: "White Fang", price: 4.35, quantity: 80, category_id: category_adventures.id, description: description)
#book_23 = Book.create(title: "The Mysterious Island", price: 6.99, quantity: 53, category_id: category_adventures.id, description: description)
#book_24 = Book.create(title: "The Memoirs of Sherlock Holmes", price: 8.99, quantity: 62, category_id: category_adventures.id, description: description)
#book_25 = Book.create(title: "The Count of Monte Cristo", price: 14.89, quantity: 15, category_id: category_adventures.id, description: description)

#---------------history
#book_31 = Book.create(title: "The Prince", price: 16.95, quantity: 13, category_id: category_history.id, description: description)
#book_32 = Book.create(title: "The Pit", price: 15.77, quantity: 22, category_id: category_history.id, description: description)
#book_33 = Book.create(title: "The Death of Ivan Ilyich", price: 12.12, quantity: 44, category_id: category_history.id, description: description)
#book_34 = Book.create(title: "Anna Karenina", price: 11.66, quantity: 69, category_id: category_history.id, description: description)
#book_35 = Book.create(title: "Seventeen Moments of Spring", price: 17.99, quantity:96, category_id: category_history.id, description: description)

review = "Writing a book review is not the same as writing a book report or a summary. A book review is a critical analysis of a published work that assesses the work's strengths and weaknesses. Many authors strive to have their books reviewed by a professional because a published review (even a negative one) can be a great source of publicity."

rating_1 = Rating.create(review: review)

del_1 = Delivery.create(method: "UPS Ground", price: 5)
del_2 = Delivery.create(method: "UPS Two Day", price: 10)
del_3 = Delivery.create(method: "UPS One Day", price: 15)


