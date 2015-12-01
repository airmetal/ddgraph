# ddgraph
Batch load automation of CSV files into Neo4J

#Instructions:

1) Start Neo4j and open the link (e.g. http://localhost:7474)

2) Copy (from CypherQueries.cql), paste each command (multiline ending with semi-colon) and hit ENTER, on the Cypher prompt ($) in the UI. NOTE: the file paths to CSV's in the commands will need to reflect your local paths to these files.

3) Execute query to show the map:
   MATCH (Locations)-[r:CONTAINS]->(NetworkDomain) RETURN r
   
4) View the results in the graph display and click on the bubbles to expand 
