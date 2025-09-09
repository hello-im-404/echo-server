# Компилятор и флаги
CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -pedantic
LDFLAGS = 

# Директории
SRC_DIR = .
BUILD_DIR = build
BIN_DIR = $(BUILD_DIR)/bin
OBJ_DIR = $(BUILD_DIR)/obj

# Исходные файлы
SERVER_SRC = $(SRC_DIR)/server.c
CLIENT_SRC = $(SRC_DIR)/client.c

# Объектные файлы
SERVER_OBJ = $(OBJ_DIR)/server.o
CLIENT_OBJ = $(OBJ_DIR)/client.o

# Исполняемые файлы
SERVER_EXE = $(BIN_DIR)/server
CLIENT_EXE = $(BIN_DIR)/client

# Создание директорий
$(shell mkdir -p $(BIN_DIR) $(OBJ_DIR))

# Цель по умолчанию
all: $(SERVER_EXE) $(CLIENT_EXE)

# Сборка сервера
$(SERVER_EXE): $(SERVER_OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

# Сборка клиента
$(CLIENT_EXE): $(CLIENT_OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

# Компиляция .c файлов в .o файлы
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Очистка
clean:
	rm -rf $(BUILD_DIR)

# Пересборка
re: clean all

# Показать структуру папок
tree:
	@echo "Структура проекта:"
	@tree -a || ls -la

# Запуск сервера (пример)
run-server: $(SERVER_EXE)
	@echo "Запуск сервера..."
	@$(SERVER_EXE)

# Запуск клиента (пример)
run-client: $(CLIENT_EXE)
	@echo "Запуск клиента..."
	@$(CLIENT_EXE)

# PHONY цели
.PHONY: all clean re tree run-server run-client
