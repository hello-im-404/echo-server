#include <sys/socket.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <arpa/inet.h>
#include <stdio.h>

int main(int argc, char **argv){
    int sock;
    struct sockaddr_in server_addr;
    char buf[1024];
    char msg[1024]; 
    
    printf("Enter message: ");
    scanf("%1023s", msg); 
    
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if(sock < 0){
        perror("Socket failed");
        exit(EXIT_FAILURE);
    }
    
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(4040);
    server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    if(connect(sock, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0){
        perror("Connection failed");
        close(sock);
        exit(EXIT_FAILURE);
    }
    
    printf("Successfully connected to server\n");
    
    send(sock, msg, strlen(msg), 0);
    
    recv(sock, buf, sizeof(buf), 0);
    printf("Server response: %s\n", buf);
    
    close(sock);
    return 0;
}
