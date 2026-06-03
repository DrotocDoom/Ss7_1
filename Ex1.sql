CREATE TABLE bookshop.book (
                               book_id SERIAL PRIMARY KEY,
                               title VARCHAR(255),
                               author VARCHAR(100),
                               genre VARCHAR(50),
                               price DECIMAL(10,2),
                               description TEXT,
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO bookshop.book (title, author, genre, price, description)
VALUES
    ('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 'Fantasy', 250000, 'A young wizard begins his journey.'),
    ('Harry Potter and the Chamber of Secrets', 'J.K. Rowling', 'Fantasy', 270000, 'The second year at Hogwarts.'),
    ('Harry Potter and the Prisoner of Azkaban', 'J.K. Rowling', 'Fantasy', 290000, 'A mysterious prisoner escapes.'),
    ('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 300000, 'Adventure in Middle-earth.'),
    ('The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 500000, 'Epic fantasy trilogy.'),
    ('A Game of Thrones', 'George R.R. Martin', 'Fantasy', 450000, 'Political struggles in Westeros.'),
    ('Clean Code', 'Robert C. Martin', 'Programming', 400000, 'Guide to writing clean code.'),
    ('Clean Architecture', 'Robert C. Martin', 'Programming', 420000, 'Software architecture principles.'),
    ('Effective Java', 'Joshua Bloch', 'Programming', 550000, 'Best practices for Java developers.'),
    ('Java Concurrency in Practice', 'Brian Goetz', 'Programming', 600000, 'Concurrency concepts in Java.'),
    ('The Pragmatic Programmer', 'Andrew Hunt', 'Programming', 450000, 'Programming craftsmanship.'),
    ('Deep Learning', 'Ian Goodfellow', 'AI', 700000, 'Introduction to deep learning.'),
    ('Artificial Intelligence', 'Stuart Russell', 'AI', 750000, 'Modern AI concepts.'),
    ('Machine Learning Yearning', 'Andrew Ng', 'AI', 350000, 'Practical ML strategies.'),
    ('Data Science Handbook', 'Jake VanderPlas', 'Data Science', 480000, 'Data science techniques.'),
    ('Python for Data Analysis', 'Wes McKinney', 'Data Science', 520000, 'Using pandas effectively.'),
    ('The Da Vinci Code', 'Dan Brown', 'Mystery', 280000, 'Mystery thriller novel.'),
    ('Angels and Demons', 'Dan Brown', 'Mystery', 260000, 'Symbolism and secrets.'),
    ('Sherlock Holmes', 'Arthur Conan Doyle', 'Mystery', 240000, 'Classic detective stories.'),
    ('Murder on the Orient Express', 'Agatha Christie', 'Mystery', 220000, 'Famous detective novel.');



CREATE INDEX idx_author ON bookshop.book (author);

DROP INDEX bookshop.idx_author;

CREATE INDEX idx_genre ON bookshop.book (genre);
DROP INDEX  bookshop.idx_genre;

EXPLAIN ANALYSE SELECT *
                FROM bookshop.book
                WHERE author LIKE '%Rowling%';

EXPLAIN ANALYSE SELECT *
                FROM bookshop.book
                WHERE genre = 'Fantasy';

CREATE INDEX idx_book_genre_btree
    ON bookshop.book (genre);

CREATE INDEX idx_book_title_fts
    ON bookshop.book
        USING GIN (
                   to_tsvector('english', title)
            );

EXPLAIN ANALYSE
SELECT *
FROM bookshop.book
WHERE to_tsvector('english', title)
          @@ to_tsquery('java & programming');

SELECT * FROM bookshop.book;
CREATE INDEX idx_genre ON bookshop.book (genre);
CLUSTER bookshop.book USING idx_genre;

EXPLAIN ANALYSE SELECT * FROM bookshop.book WHERE genre = 'AI'


