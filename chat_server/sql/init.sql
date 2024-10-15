-- 初始化一个chat系统的user表
CREATE TABLE IF NOT EXISTS users(
    id bigserial PRIMARY KEY,
    fullname varchar(64) NOT NULL,
    email VARCHAR(64) UNIQUE NOT NULL,
    password VARCHAR(64) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- 创建email索引
CREATE UNIQUE INDEX IF NOT EXISTS email_index ON users(email);


-- 创建一个chat_type枚举类型
CREATE TYPE chat_type AS ENUM ('single','group','public_channel','private_channel');
-- CHATS表
CREATE TABLE IF NOT EXISTS chats (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(128),
    type chat_type NOT NULL,
    members BIGINT[] NOT NULL,
    created_at TMIESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- MESSAGES表
CREATE TABLE IF NOT EXISTS messages (
    id BIGSERIAL PRIMARY KEY,
    chat_id BIGINT NOT NULL,
    sender_id BIGINT NOT NULL,
    content TEXT,
    images TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- 添加外键约束，可以设置级联操作，父表记录被删除时，子表相应的记录也会被删除
    FOREIGN KEY (chat_id) REFERENCES chats(id),
    FOREIGN KEY (sender_id) REFERENCES users(id),
);
-- 创建chat_id和created_at联合索引
CREATE INDEX IF NOT EXISTS chat_id_created_at_index ON messages(chat_id,created_at);
-- 创建sender_id索引
CREATE INDEX IF NOT EXISTS sender_index ON messages(sender_id);
