#include <sys/socket.h>
#include <stdio.h>
#include <errno.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <netinet/in.h>
#include <stdlib.h>

int Socket(int domain, int type, int protocol) {
    int res = socket(domain, type, protocol);
    if (res < 0) {
        perror("Error with socket");
        exit(EXIT_FAILURE);
    }
    return res;
}

void Bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen) {
    int res = bind(sockfd, addr, addrlen); 
    if (res < 0) {
        perror("Error with bind");
        exit(EXIT_FAILURE);
    }
}

void Listen(int sockfd, int backlog) {
    int res = listen(sockfd, backlog);
    if (res < 0) {
        perror("Error with listen");
        exit(EXIT_FAILURE);
    }
}

int Accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen) {
    int res = accept(sockfd, addr, addrlen);
    if (res < 0) {
        perror("Error with accept");
        exit(EXIT_FAILURE);
    }
    return res;
}

int main(void) {
    int serverfd;
    struct sockaddr_in address;
    socklen_t addrlen = sizeof(address); 

    serverfd = Socket(AF_INET, SOCK_STREAM, 0);

    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(4040); 

    Bind(serverfd, (struct sockaddr *)&address, sizeof(address));

    Listen(serverfd, 5);

    printf("Starting listening on port 4040...\n");

    int new_socket = Accept(serverfd, (struct sockaddr *)&address, &addrlen);
    printf("Connected successfully!\n");

    char buffer[1024] = {0};
    int valread = read(new_socket, buffer, 1024);
    printf("Received: %s\n", buffer);
    send(new_socket, buffer, valread, 0);
    printf("Echo message sent\n");

    close(new_socket);
    close(serverfd);
    return 0; 
}
