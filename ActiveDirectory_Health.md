### Dcdiag analyzes the state of domain controllers in a forest or enterprise and reports any problems to help in troubleshooting

```dcdiag /c /e /v```

### Replsummary operation quickly and concisely summarizes the replication state

```repadmin /replsummary```

### Synchronizes a specified domain controller with all replication

```repadmin /syncall /e```

```repadmin /syncall /Aped```

### Forces the KCC on targeted domain controller

```repadmin /kcc *```

### Find the last time your DC were backup

```Repadmin /showbackup *```

### Output all replication summary information from all DC Server

```Repadmin /showrepl *```

### Displays inbound replication requests that the domain controller

```Repadmin /queue *```

### List the Domain Controllers in Active Directory

```DSQUERY Server -o rdn```

### Identifies domain controllers that are failing inbound replication or outbound replication

```Repadmin /replsummary```

### Displays calls that have not yet been answered

```repadmin /showoutcalls *```

### List the Topology information

```repadmin /bridgeheads * /verbose```

### Inter Site Topology Generator Report

```repadmin /istg * /verbose```

### Displays a list of failed replication events detected by the Knowledge Consistency Checker (KCC)

```repadmin /failcache *```

### Lists all domains trusted by a specified domain

```Repadmin /showtrust *```

### Displays the replication features for, a directory partition on a domain controller

```repadmin /bind *```

### DNS 

```DCDiag /test:DNS /e /v >c:\dns.txt```

```dcdiag /test:RegisterInDns /DnsDomain:example.com```

```dcdiag /test:dns /dnsrecordregistration /v```

```dcdiag /test:dns /dnsdynamicupdate /v```

```dcdiag /test:netlogons```

```dcdiag /v```

### Identifies domain controllers that are failing inbound replication or outbound replication, and summarizes the results in a report.

```Repadmin /replsummary```

```repadmin /replsum * /bysrc /bydest /sort:delta```

#### Displays inbound replication requests that the domain controller

```Repadmin /Queue```

### Displays the replication status when the specified domain controller last attempted to perform inbound replication on Active Directory partitions.

```Repadmin /Showrepl```

```repadmin /showrepl * /errorsonly```

```repadmin /showrepl site:Default-First-Site-Name DC=example,dc=com```

```Repadmin /showbackup *```