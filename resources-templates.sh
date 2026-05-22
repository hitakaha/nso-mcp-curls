#!/usr/bin/bash
USERNAME=admin
PASSWORD=admin
NSO_URL=localhost

curl -u "${USERNAME}:${PASSWORD}" "http://${NSO_URL}:8080/mcp" -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":1,"method":"resources/templates/list","params":{}}' | jq
