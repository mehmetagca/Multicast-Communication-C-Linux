# Multicast-Communication-C-Linux
Multicast Communication in C language on Linux

Source: https://www.tenouk.com/Module41c.html

Example: Sending and receiving a multicast datagram

    IP multicasting provides the capability for an application to send a single IP datagram that a group of hosts in a network can receive.  The hosts that are in the group may reside on a single subnet or may be on different subnets that have been connected by multicast capable routers.

    Hosts may join and leave groups at any time.  There are no restrictions on the location or number of members in a host group.  A class D Internet address in the range 224.0.0.1 to 239.255.255.255 identifies a host group.

    An application program can send or receive multicast datagrams by using the socket() API and connectionless SOCK_DGRAM type sockets.  Each multicast transmission is sent from a single network interface, even if the host has more than one multicasting-capable interface.

    It is a one-to-many transmission method.  You cannot use connection-oriented sockets of type SOCK_STREAM for multicasting.

    When a socket of type SOCK_DGRAM is created, an application can use the setsockopt() function to control the multicast characteristics associated with that socket.  The setsockopt() function accepts the following IPPROTO_IP level flags:

        IP_ADD_MEMBERSHIP:  Joins the multicast group specified.

        IP_DROP_MEMBERSHIP:  Leaves the multicast group specified.

        IP_MULTICAST_IF:  Sets the interface over which outgoing multicast datagrams are sent.

        IP_MULTICAST_TTL:  Sets the Time To Live (TTL) in the IP header for outgoing multicast datagrams.  By default it is set to 1.  TTL of 0 are not transmitted on any sub-network.  Multicast datagrams with a TTL of greater than 1 may be delivered to more than one sub-network, if there are one or more multicast routers attached to the first sub-network.

        IP_MULTICAST_LOOP:  Specifies whether or not a copy of an outgoing multicast datagram is delivered to the sending host as long as it is a member of the multicast group.

    The following examples enable a socket to send and receive multicast datagrams.  The steps needed to send a multicast datagram differ from the steps needed to receive a multicast datagram.

Server:
        Create an AF_INET, SOCK_DGRAM type socket.

        Initialize a sockaddr_in structure with the destination group IP address and port number.

        Set the IP_MULTICAST_LOOP socket option according to whether the sending system should receive a copy of the multicast datagrams that are transmitted.

        Set the IP_MULTICAST_IF socket option to define the local interface over which you want to send the multicast datagrams.

        Send the datagram.
        
Client:
        Create an AF_INET, SOCK_DGRAM type socket.

        Set the SO_REUSEADDR option to allow multiple applications to receive datagrams that are destined to the same local port number.

        Use the bind() verb to specify the local port number.  Specify the IP address as INADDR_ANY in order to receive datagrams that are addressed to a multicast group.

        Use the IP_ADD_MEMBERSHIP socket option to join the multicast group that receives the datagrams.  When joining a group, specify the class D group address along with the IP address of a local interface.  The system must call the IP_ADD_MEMBERSHIP socket option for each local interface receiving the multicast datagrams.

        Receive the datagram.
        
Output:
$ ./mcast_client
Opening datagram socket....OK.
Setting SO_REUSEADDR...OK.
Binding datagram socket...OK.
Adding multicast group...OK.
Reading datagram message...OK.
The message from multicast server is: "Multicast test message!"

$ ./mcast_server
Opening the datagram socket...OK.
Setting the local interface...OK
Sending datagram message...OK

