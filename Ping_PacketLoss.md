
### Mac
Open the Terminal application:

```
ping -c 50  8.8.8.8
```

After one minute, you should see something like:

50 packets transmitted, 50 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 58.761/59.494/60.527/0.413 ms


### Windows 
Type the following command and hit Enter.

```
ping -n 50 8.8.8.8
```

After one minute, you should see something like:

Ping statistics for 8.8.8.8:
    Packets: Sent = 50, Received = 50, Lost = 1 (2% loss).  

In this case, packet loss is 2%.
