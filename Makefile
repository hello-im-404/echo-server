CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -pedantic
LDFLAGS = 

SRC_DIR = .
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

tree:
	@echo "Структура проекта:"
	@tree -a || ls -la

run-server: $(SERVER_EXE)
	@echo "Запуск сервера..."
	@$(SERVER_EXE)

run-client: $(CLIENT_EXE)
	@echo "Запуск клиента..."
	@$(CLIENT_EXE)

.PHONY: all clean re tree run-server run-client
