
MATCH (n)
WITH n LIMIT 100000
OPTIONAL MATCH (n)-[r]->()
DELETE n,r;

LOAD CSV WITH HEADERS FROM "file:///C:/Users/Administrator/Documents/GitHub/ccresource-master/data/locations.csv"
  AS line
CREATE (l:Locations {datacenterId:line.id, display:line.displayName, type:line.type});

LOAD CSV WITH HEADERS FROM "file:///C:/Users/Administrator/Documents/GitHub/ccresource-master/data/networkdomain.csv"
  AS line
MATCH (l:Locations {datacenterId:line.datacenterId})
MERGE (d:NetworkDomain {type:line.type, name:line.name,networkdDomainId:line.id})
CREATE (l)-[:CONTAINS]->(d);

LOAD CSV WITH HEADERS FROM "file:///C:/Users/Administrator/Documents/GitHub/ccresource-master/data/vlans.csv"
  AS line
MATCH (d:NetworkDomain {networkdDomainId:line.`networkDomain.id`})
MERGE (v:Vlan {networkdomainName:line.`networkDomain.name`, name:line.name,vlanId:line.id})
CREATE (d)-[:MAPS_TO]->(v);

LOAD CSV WITH HEADERS FROM "file:///C:/Users/Administrator/Documents/GitHub/ccresource-master/data/servers.csv"
  AS line
MATCH (v:Vlan {vlanId:line.`networkInfo.primaryNic.vlanId`})
MERGE (s:Servers {serverName:line.name, serverId:line.id})
CREATE (v)-[:HOSTS]->(s);

LOAD CSV WITH HEADERS FROM "file:///C:/Users/Administrator/Documents/GitHub/ccresource-master/data/publicips.csv"
  AS line
MATCH (d:NetworkDomain {networkdDomainId:line.networkDomainId})
MERGE (p:PublicIps {baseIp:line.baseIp, size:line.size, publicipId:line.id})
CREATE (p)-[:ATTACHED_TO]->(d);

LOAD CSV WITH HEADERS FROM "file:///C:/Users/Administrator/Documents/GitHub/ccresource-master/data/firewallrule.csv"
  AS line
MATCH (d:NetworkDomain {networkdDomainId:line.networkDomainId})
MERGE (f:FirewallRules {name:line.name,action:line.action,protocol:line.protocol,sourceIp:line.`source.ip.address`,destinationIp:line.`destination.ip.address`,destinationPort:line.`destination.port.begin`,enabled:line.enabled,firewallRuleId:line.id,ruleType:line.ruleType})
CREATE (f)-[:APPLIES_TO]->(d);

LOAD CSV WITH HEADERS FROM "file:///C:/Users/Administrator/Documents/GitHub/ccresource-master/data/natrule.csv"
  AS line
MATCH (p:PublicIps {baseIp:line.baseIp})
MERGE (n:NatRules {internalIp:line.internalIp,externalIp:line.externalIp})
CREATE (n)-[:SECURES]->(p);





