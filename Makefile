CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -pedantic -g
LDFLAGS =

SRC_DIR = src
BUILD_DIR = build
BIN_DIR = $(BUILD_DIR)/bin
OBJ_DIR = $(BUILD_DIR)/obj

SERVER_SRC = $(SRC_DIR)/server.c
CLIENT_SRC = $(SRC_DIR)/client.c

SERVER_OBJ = $(OBJ_DIR)/server.o
CLIENT_OBJ = $(OBJ_DIR)/client.o

SERVER_EXE = $(BIN_DIR)/server
CLIENT_EXE = $(BIN_DIR)/client

$(shell mkdir -p $(BIN_DIR) $(OBJ_DIR))

all: $(SERVER_EXE) $(CLIENT_EXE)

$(SERVER_EXE): $(SERVER_OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

$(CLIENT_EXE): $(CLIENT_OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf $(BUILD_DIR)

re: clean all

help:
	@echo "Доступные команды:"
	@echo "  make all      - собрать все цели"
	@echo "  make server   - собрать только сервер"
	@echo "  make client   - собрать только клиент"
	@echo "  make clean    - очистить проект"
	@echo "  make re       - пересобрать проект"
	@echo "  make tree     - показать структуру проекта"
	@echo "  make run-server - запустить сервер"
	@echo "  make run-client - запустить клиента"
	@echo "  make run-both  - запустить сервер и клиент"
	@echo "  make debug    - отладочная информация"
	@echo "  make help     - эта справка"

