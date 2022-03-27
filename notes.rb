INSERT INTO bookmarks (url, title) VALUES('https://www.makers.tech', '') DROP TABLE bookmarks') RETURNING id, title, url;
