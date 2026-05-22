# CURL Scripts for NSO MCP
Sample curl scripts to get Tools/Prompts/Resources from NSO MCP server.
Following is sample outputs on NSO 6.7 with bgpmgr pacakge.


# Tools
<details>
<summary> Click to expand </summary>
  
```
{
  "id": 1,
  "jsonrpc": "2.0",
  "result": {
    "tools": [
      {
        "description": "Echo back a message with user context (sample tool)",
        "inputSchema": {
          "properties": {
            "message": {
              "description": "Message to echo back",
              "type": "string"
            }
          },
          "required": [
            "message"
          ],
          "type": "object"
        },
        "name": "echo"
      },
      {
        "description": "NSO Action: load-modules (path: /tfnm:ncs-state/patches/load-modules)",
        "inputSchema": {
          "properties": {
            "force-purge": {
              "description": "force-purge",
              "type": "boolean"
            },
            "name": {
              "description": "name (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            }
          },
          "required": [
            "name"
          ],
          "type": "object"
        },
        "name": "tfnm_ncs_state_patches_load_modules"
      },
      {
        "description": "NSO Action: set-read-only (path: /tfnm:ncs-state/set-read-only)",
        "inputSchema": {
          "properties": {
            "mode": {
              "description": "mode",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "tfnm_ncs_state_set_read_only"
      },
      {
        "description": "NSO Action: Remove events (path: /progress:progress/trace/purge)",
        "inputSchema": {
          "properties": {
            "__key__trace__name": {
              "description": "Key for 'trace' list in action path - A unique name for this progress trace.",
              "type": "string",
              "x-list-tag": "trace",
              "x-path-key": true
            },
            "older-than": {
              "description": "Matches the 'when' leaf in the event.",
              "properties": {
                "days": {
                  "description": "days",
                  "type": "integer"
                },
                "hours": {
                  "description": "hours",
                  "type": "integer"
                },
                "minutes": {
                  "description": "minutes",
                  "type": "integer"
                },
                "seconds": {
                  "description": "seconds",
                  "type": "integer"
                },
                "weeks": {
                  "description": "weeks",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__trace__name"
          ],
          "type": "object"
        },
        "name": "progress_progress_trace_purge"
      },
      {
        "description": "NSO Action: get-rollback-file (path: /rollback:rollback-files/get-rollback-file)",
        "inputSchema": {
          "properties": {
            "fixed-number": {
              "description": "fixed-number",
              "type": "integer"
            },
            "id": {
              "description": "id",
              "type": "integer"
            }
          },
          "type": "object"
        },
        "name": "rollback_rollback_files_get_rollback_file"
      },
      {
        "description": "NSO Action: apply-rollback-file (path: /rollback:rollback-files/apply-rollback-file)",
        "inputSchema": {
          "properties": {
            "comment": {
              "description": "A comment attached to any rollback file created as a result\nof the transaction. If supported, the comment will also\nbe propagated down to the device.",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "The error option to use. Depending on the selected error option\nNCS will store the reverse of the original transaction\nto be able to undo the transaction changes and get back to the\nprevious state. This data is stored in the\n/devices/commit-queue/completed tree from where it can\nbe viewed and invoked with the rollback action. When invoked\nthe data will be removed.",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "Unique id identifying a queue item. If locked, this\nitem will be unlocked in the commit phase.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "If this container is created, the commit will make a\nconfirm-network-state sync check on the participating devices.",
              "properties": {
                "compare": {
                  "description": "The scope of the confirm-network-state check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "Re-evaluate all saved extra-create-ops operations\nagainst the current set of out-of-band policies.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "exclude": {
              "description": "exclude (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "fixed-number": {
              "description": "fixed-number",
              "type": "integer"
            },
            "id": {
              "description": "id",
              "type": "integer"
            },
            "label": {
              "description": "User defined label. The label is present in\nrollback files, notifications and events referencing\nthe transaction.",
              "type": "string"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "no-networking": {
              "description": "Do not send any data to the devices. Even if the transaction\nmanipulates data below /devices/device/config, nothing will\nbe sent to the managed devices. This is a way to manipulate\nCDB in NCS without generating any southbound traffic.",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that a device's\nconfiguration is out of sync. The device's sync state is assumed\nto be unknown after such commit and the stored transaction id\nvalue is cleared",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "This flag means that NCS will check that the modified data and\noptionally the data read when computing the device modifications\nhave not changed on the device compared to NCS's view of the data.\nValidating the data read when computing the device modifications\nis important because the read data might be a prerequisite to\nbeing able to write the data successfully; there might exist\nconstraints on the modified data (e.g., a 'must' statement) that\nare fulfilled in NCS but not on the device.\n\nThis is a fine-grained sync check; NCS verifies that NCS\nand the device are in sync regarding the data that will be\nmodified and optionally the data read when computing the device\nmodifications. If they are not in sync, the transaction is\naborted.",
              "properties": {
                "compare": {
                  "description": "The scope of the no-overwrite check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "This flag means that NCS will not run its data model revision\nalgorithm, which requires all participating managed devices\nto have all parts of the data models for all data contained\nin this transaction. Thus, this flag forces NCS to never\nsilently drop any data set operations towards a device.",
              "type": "boolean"
            },
            "path": {
              "description": "path",
              "type": "string"
            },
            "selective": {
              "description": "selective",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "Force handling of the LSA nodes as such. This flag tells\nNCS to propagate applicable commit flags and actions\nto the LSA nodes without applying them on the upper\nNCS node itself. The commit flags affected are\n'dry-run', 'no-networking', 'no-out-of-sync-check',\n'no-overwrite', 'no-revision-drop' and 'confirm-network-state'.",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "rollback_rollback_files_apply_rollback_file"
      },
      {
        "description": "NSO Action: Ping node using Distributed Erlang protocol. (path: /haraft:ha-raft/network/ping)",
        "inputSchema": {
          "properties": {
            "node": {
              "description": "node",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "haraft_ha_raft_network_ping"
      },
      {
        "description": "NSO Action: Resolve IP address of node. (path: /haraft:ha-raft/network/resolve-address)",
        "inputSchema": {
          "properties": {
            "ip-version": {
              "description": "Filter address type to specific IP version, or 'unknown' for\nno filtering.",
              "enum": [
                "ipv6",
                "ipv4",
                "unknown"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "unknown",
                "1": "ipv4",
                "2": "ipv6"
              }
            },
            "node": {
              "description": "node",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "haraft_ha_raft_network_resolve_address"
      },
      {
        "description": "NSO Action: Scan TCP port(s) on the specified node. (path: /haraft:ha-raft/network/scan-ports)",
        "inputSchema": {
          "properties": {
            "ip-version": {
              "description": "Filter address type to specific IP version, or 'unknown' for\nno filtering.",
              "enum": [
                "ipv6",
                "ipv4",
                "unknown"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "unknown",
                "1": "ipv4",
                "2": "ipv6"
              }
            },
            "node": {
              "description": "node",
              "type": "string"
            },
            "port": {
              "description": "port (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            }
          },
          "type": "object"
        },
        "name": "haraft_ha_raft_network_scan_ports"
      },
      {
        "description": "NSO Action: Initialise an HA Raft cluster. This action should only be\ninvoked once to form a new cluster when no HA Raft log\nexists. (path: /haraft:ha-raft/create-cluster)",
        "inputSchema": {
          "properties": {
            "member": {
              "description": "The members of the HA Raft cluster consist of the NCS\nnode where the '/ha-raft/create-cluster' action is\ninvoked, which will become the leader of the cluster;\nand the members specified by the 'member' parameter.",
              "items": {
                "type": "string"
              },
              "type": "array"
            }
          },
          "type": "object"
        },
        "name": "haraft_ha_raft_create_cluster"
      },
      {
        "description": "NSO Action: Add or remove an HA node from the HA Raft cluster. (path: /haraft:ha-raft/adjust-membership)",
        "inputSchema": {
          "properties": {
            "add-node": {
              "description": "add-node",
              "type": "string"
            },
            "remove-node": {
              "description": "remove-node",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "haraft_ha_raft_adjust_membership"
      },
      {
        "description": "NSO Action: Disconnect an HA node from all remaining nodes. In the event\nof revoking a TLS certificate, invoke this action to\ndisconnect the already established connections to the node\nwith the revoked certificate. A disconnected node with a\nvalid TLS certificate may re-establish the connection. (path: /haraft:ha-raft/disconnect)",
        "inputSchema": {
          "properties": {
            "node": {
              "description": "node",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "haraft_ha_raft_disconnect"
      },
      {
        "description": "NSO Action: Reset the (disabled) local node to make the leader perform\na full sync to this local node if there exists an HA Raft\ncluster. If reset is performed on the leader node, the\nnode will step down from leadership and it will be synced\nby the next leader node.\n\nAn HA Raft member will change role to 'disabled' if\nncs.conf(5) has incompatible changes to the ncs.conf on\nthe leader; a member will also change role to 'disabled'\nif there are non-recoverable failures upon opening a\nsnapshot.\n\nSee the /ha-raft/status/disable-reason leaf for reason. (path: /haraft:ha-raft/reset)",
        "inputSchema": {
          "properties": {
            "force": {
              "description": "DEPRECATED: This parameter is deprecated and use of it is ignored.\nIt will be removed in a future release. For leader nodes, invoke\nthe /ha-raft/handover action instead.",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "haraft_ha_raft_reset"
      },
      {
        "description": "NSO Action: Handover leadership to another member of the HA Raft cluster\nor stepdown from leadership and start a new election. (path: /haraft:ha-raft/handover)",
        "inputSchema": {
          "properties": {
            "to-member": {
              "description": "The member to handover the leadership of the HA Raft\ncluster.",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "haraft_ha_raft_handover"
      },
      {
        "description": "NSO Action: Toggle read-only mode, if the mode is 'true' no configuration\nchanges can occur.\n\nDEPRECATED: Use /system/read-only action instead. (path: /haraft:ha-raft/read-only)",
        "inputSchema": {
          "properties": {
            "mode": {
              "description": "mode",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "haraft_ha_raft_read_only"
      },
      {
        "description": "NSO Action: Remove history entries (path: /scheduler:scheduler/task/history/purge)",
        "inputSchema": {
          "properties": {
            "__key__task__name": {
              "description": "Key for 'task' list in action path - A unique name for this task.",
              "type": "string",
              "x-list-tag": "task",
              "x-path-key": true
            },
            "older-than": {
              "description": "Matches the 'when' leaf in the history entry.",
              "properties": {
                "days": {
                  "description": "days",
                  "type": "integer"
                },
                "hours": {
                  "description": "hours",
                  "type": "integer"
                },
                "minutes": {
                  "description": "minutes",
                  "type": "integer"
                },
                "seconds": {
                  "description": "seconds",
                  "type": "integer"
                },
                "weeks": {
                  "description": "weeks",
                  "type": "integer"
                }
              },
              "type": "object"
            },
            "succeeded": {
              "description": "succeeded",
              "type": "boolean"
            }
          },
          "required": [
            "__key__task__name"
          ],
          "type": "object"
        },
        "name": "scheduler_scheduler_task_history_purge"
      },
      {
        "description": "NSO Action: Display the next run times for the task. (path: /scheduler:scheduler/task/get-next-run-times)",
        "inputSchema": {
          "properties": {
            "__key__task__name": {
              "description": "Key for 'task' list in action path - A unique name for this task.",
              "type": "string",
              "x-list-tag": "task",
              "x-path-key": true
            },
            "display": {
              "description": "display",
              "type": "integer"
            }
          },
          "required": [
            "__key__task__name"
          ],
          "type": "object"
        },
        "name": "scheduler_scheduler_task_get_next_run_times"
      },
      {
        "description": "NSO Action: Suspend all tasks in the scheduler. (path: /scheduler:scheduler/suspend)",
        "inputSchema": {
          "type": "object"
        },
        "name": "scheduler_scheduler_suspend"
      },
      {
        "description": "NSO Action: Resume all tasks in the scheduler. (path: /scheduler:scheduler/resume)",
        "inputSchema": {
          "type": "object"
        },
        "name": "scheduler_scheduler_resume"
      },
      {
        "description": "NSO Action: Delete this alarm (path: /al:alarms/alarm-list/alarm/purge)",
        "inputSchema": {
          "properties": {
            "__key__alarm__device": {
              "description": "Key for 'alarm' list in action path - The alarming device",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            },
            "__key__alarm__managed-object": {
              "description": "Key for 'alarm' list in action path - The alarming object",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            },
            "__key__alarm__specific-problem": {
              "description": "Key for 'alarm' list in action path - Alarm type refinement",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            },
            "__key__alarm__type": {
              "description": "Key for 'alarm' list in action path - Unique identification of the alarm type",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            }
          },
          "required": [
            "__key__alarm__device",
            "__key__alarm__type",
            "__key__alarm__managed-object",
            "__key__alarm__specific-problem"
          ],
          "type": "object"
        },
        "name": "al_alarms_alarm_list_alarm_purge"
      },
      {
        "description": "NSO Action: Compress the history of state changes for this alarm (path: /al:alarms/alarm-list/alarm/compress)",
        "inputSchema": {
          "properties": {
            "__key__alarm__device": {
              "description": "Key for 'alarm' list in action path - The alarming device",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            },
            "__key__alarm__managed-object": {
              "description": "Key for 'alarm' list in action path - The alarming object",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            },
            "__key__alarm__specific-problem": {
              "description": "Key for 'alarm' list in action path - Alarm type refinement",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            },
            "__key__alarm__type": {
              "description": "Key for 'alarm' list in action path - Unique identification of the alarm type",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            }
          },
          "required": [
            "__key__alarm__device",
            "__key__alarm__type",
            "__key__alarm__managed-object",
            "__key__alarm__specific-problem"
          ],
          "type": "object"
        },
        "name": "al_alarms_alarm_list_alarm_compress"
      },
      {
        "description": "NSO Action: Set the operator state of this alarm (path: /al:alarms/alarm-list/alarm/handle-alarm)",
        "inputSchema": {
          "properties": {
            "__key__alarm__device": {
              "description": "Key for 'alarm' list in action path - The alarming device",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            },
            "__key__alarm__managed-object": {
              "description": "Key for 'alarm' list in action path - The alarming object",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            },
            "__key__alarm__specific-problem": {
              "description": "Key for 'alarm' list in action path - Alarm type refinement",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            },
            "__key__alarm__type": {
              "description": "Key for 'alarm' list in action path - Unique identification of the alarm type",
              "type": "string",
              "x-list-tag": "alarm",
              "x-path-key": true
            },
            "description": {
              "description": "Additional optional textual information regarding\nthis new alarm-handling entry.",
              "type": "string"
            },
            "state": {
              "description": "state",
              "enum": [
                "closed",
                "observation",
                "investigation",
                "ack",
                "none"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "1": "none",
                "2": "ack",
                "3": "investigation",
                "4": "observation",
                "5": "closed"
              }
            }
          },
          "required": [
            "__key__alarm__device",
            "__key__alarm__type",
            "__key__alarm__managed-object",
            "__key__alarm__specific-problem"
          ],
          "type": "object"
        },
        "name": "al_alarms_alarm_list_alarm_handle_alarm"
      },
      {
        "description": "NSO Action: Synchronize the alarm state from the device (path: /al:alarms/synchronize-alarms)",
        "inputSchema": {
          "type": "object"
        },
        "name": "al_alarms_synchronize_alarms"
      },
      {
        "description": "NSO Action: Compress the history of state changes for each alarm (path: /al:alarms/compress-alarms)",
        "inputSchema": {
          "type": "object"
        },
        "name": "al_alarms_compress_alarms"
      },
      {
        "description": "NSO Action: Show the keys for all alarm matching the criteria (path: /al:alarms/filter-alarms)",
        "inputSchema": {
          "properties": {
            "alarm-handling-state-filter": {
              "description": "alarm-handling-state-filter",
              "properties": {
                "state": {
                  "description": "state",
                  "enum": [
                    "closed",
                    "observation",
                    "investigation",
                    "ack",
                    "none"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "1": "none",
                    "2": "ack",
                    "3": "investigation",
                    "4": "observation",
                    "5": "closed"
                  }
                },
                "user": {
                  "description": "user",
                  "type": "string"
                }
              },
              "type": "object"
            },
            "alarm-status": {
              "description": "alarm-status",
              "enum": [
                "not-cleared",
                "cleared",
                "any"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "any",
                "1": "cleared",
                "2": "not-cleared"
              }
            },
            "older-than": {
              "description": "Matches the 'last-status-change' leaf in the alarm.",
              "properties": {
                "days": {
                  "description": "days",
                  "type": "integer"
                },
                "hours": {
                  "description": "hours",
                  "type": "integer"
                },
                "minutes": {
                  "description": "minutes",
                  "type": "integer"
                },
                "seconds": {
                  "description": "seconds",
                  "type": "integer"
                },
                "weeks": {
                  "description": "weeks",
                  "type": "integer"
                }
              },
              "type": "object"
            },
            "severity": {
              "description": "severity",
              "properties": {
                "above": {
                  "description": "above",
                  "enum": [
                    "critical",
                    "major",
                    "warning",
                    "minor",
                    "indeterminate",
                    "cleared"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "1": "cleared",
                    "2": "indeterminate",
                    "3": "minor",
                    "4": "warning",
                    "5": "major",
                    "6": "critical"
                  }
                },
                "below": {
                  "description": "below",
                  "enum": [
                    "critical",
                    "major",
                    "warning",
                    "minor",
                    "indeterminate",
                    "cleared"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "1": "cleared",
                    "2": "indeterminate",
                    "3": "minor",
                    "4": "warning",
                    "5": "major",
                    "6": "critical"
                  }
                },
                "is": {
                  "description": "is",
                  "enum": [
                    "critical",
                    "major",
                    "warning",
                    "minor",
                    "indeterminate",
                    "cleared"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "1": "cleared",
                    "2": "indeterminate",
                    "3": "minor",
                    "4": "warning",
                    "5": "major",
                    "6": "critical"
                  }
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "al_alarms_filter_alarms"
      },
      {
        "description": "NSO Action: Remove alarms (path: /al:alarms/purge-alarms)",
        "inputSchema": {
          "properties": {
            "alarm-handling-state-filter": {
              "description": "alarm-handling-state-filter",
              "properties": {
                "state": {
                  "description": "state",
                  "enum": [
                    "closed",
                    "observation",
                    "investigation",
                    "ack",
                    "none"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "1": "none",
                    "2": "ack",
                    "3": "investigation",
                    "4": "observation",
                    "5": "closed"
                  }
                },
                "user": {
                  "description": "user",
                  "type": "string"
                }
              },
              "type": "object"
            },
            "alarm-status": {
              "description": "alarm-status",
              "enum": [
                "not-cleared",
                "cleared",
                "any"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "any",
                "1": "cleared",
                "2": "not-cleared"
              }
            },
            "older-than": {
              "description": "Matches the 'last-status-change' leaf in the alarm.",
              "properties": {
                "days": {
                  "description": "days",
                  "type": "integer"
                },
                "hours": {
                  "description": "hours",
                  "type": "integer"
                },
                "minutes": {
                  "description": "minutes",
                  "type": "integer"
                },
                "seconds": {
                  "description": "seconds",
                  "type": "integer"
                },
                "weeks": {
                  "description": "weeks",
                  "type": "integer"
                }
              },
              "type": "object"
            },
            "severity": {
              "description": "severity",
              "properties": {
                "above": {
                  "description": "above",
                  "enum": [
                    "critical",
                    "major",
                    "warning",
                    "minor",
                    "indeterminate",
                    "cleared"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "1": "cleared",
                    "2": "indeterminate",
                    "3": "minor",
                    "4": "warning",
                    "5": "major",
                    "6": "critical"
                  }
                },
                "below": {
                  "description": "below",
                  "enum": [
                    "critical",
                    "major",
                    "warning",
                    "minor",
                    "indeterminate",
                    "cleared"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "1": "cleared",
                    "2": "indeterminate",
                    "3": "minor",
                    "4": "warning",
                    "5": "major",
                    "6": "critical"
                  }
                },
                "is": {
                  "description": "is",
                  "enum": [
                    "critical",
                    "major",
                    "warning",
                    "minor",
                    "indeterminate",
                    "cleared"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "1": "cleared",
                    "2": "indeterminate",
                    "3": "minor",
                    "4": "warning",
                    "5": "major",
                    "6": "critical"
                  }
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "al_alarms_purge_alarms"
      },
      {
        "description": "NSO Action: Kicker action to Send a kicker-triggered notification (path: /kicker:kickers/send-kicker-triggered)",
        "inputSchema": {
          "properties": {
            "kicker-id": {
              "description": "kicker-id",
              "type": "string"
            },
            "path": {
              "description": "path",
              "type": "string"
            },
            "tid": {
              "description": "tid",
              "type": "integer"
            }
          },
          "type": "object"
        },
        "name": "kicker_kickers_send_kicker_triggered"
      },
      {
        "description": "NSO Action: Show the fingerprint for the key (path: /ncs:cluster/remote-node/ssh/host-key/show-fingerprint)",
        "inputSchema": {
          "properties": {
            "__key__host-key__algorithm": {
              "description": "Key for 'host-key' list in action path - Key 'algorithm' for list 'host-key'",
              "type": "string",
              "x-list-tag": "host-key",
              "x-path-key": true
            },
            "__key__remote-node__name": {
              "description": "Key for 'remote-node' list in action path - Name of remote node",
              "type": "string",
              "x-list-tag": "remote-node",
              "x-path-key": true
            }
          },
          "required": [
            "__key__remote-node__name",
            "__key__host-key__algorithm"
          ],
          "type": "object"
        },
        "name": "ncs_cluster_remote_node_ssh_host_key_show_fingerprint"
      },
      {
        "description": "NSO Action: Retrieve host keys from remote (path: /ncs:cluster/remote-node/ssh/fetch-host-keys)",
        "inputSchema": {
          "properties": {
            "__key__remote-node__name": {
              "description": "Key for 'remote-node' list in action path - Name of remote node",
              "type": "string",
              "x-list-tag": "remote-node",
              "x-path-key": true
            }
          },
          "required": [
            "__key__remote-node__name"
          ],
          "type": "object"
        },
        "name": "ncs_cluster_remote_node_ssh_fetch_host_keys"
      },
      {
        "description": "NSO Action: Note: this action overwrites existing list of capabilities.\n\nThis action copies the list of capabilities and the list of modules\nfrom another device or profile. When used on a device, this action\nis only intended to be used for pre-provisioning: it is not possible\nto override capabilities and modules provided by the\nNED implementation using this action. (path: /ncs:devices/profiles/capabilities-profile/copy-capabilities)",
        "inputSchema": {
          "properties": {
            "__key__capabilities-profile__name": {
              "description": "Key for 'capabilities-profile' list in action path - The name of the device profile",
              "type": "string",
              "x-list-tag": "capabilities-profile",
              "x-path-key": true
            },
            "from-device": {
              "description": "from-device",
              "type": "string"
            },
            "from-profile": {
              "description": "from-profile",
              "type": "string"
            }
          },
          "required": [
            "__key__capabilities-profile__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_profiles_capabilities_profile_copy_capabilities"
      },
      {
        "description": "NSO Action: Migrate the devices to a new NED type (path: /ncs:devices/device-group/ned-id/migrate)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            },
            "__key__ned-id__id": {
              "description": "Key for 'ned-id' list in action path - Key 'id' for list 'ned-id'",
              "type": "string",
              "x-list-tag": "ned-id",
              "x-path-key": true
            },
            "dry-run": {
              "description": "Report what would be done without actually doing anything",
              "type": "boolean"
            },
            "new-ned-id": {
              "description": "The new NED Identity",
              "type": "string"
            },
            "no-networking": {
              "description": "Do not generate any southbound traffic towards the\nnetwork. Use the device configuration in CDB.",
              "type": "boolean"
            },
            "no-templates": {
              "description": "Do not automatically migrate device and compliance templates\nreferring to the old NED identity.",
              "type": "boolean"
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "report": {
              "description": "report",
              "properties": {
                "affected-devices": {
                  "description": "Report affected devices",
                  "type": "boolean"
                },
                "affected-templates": {
                  "description": "Report device and compliance templates",
                  "type": "boolean"
                },
                "all": {
                  "description": "Report all managed objects affected by the migration\n(very verbose)",
                  "type": "boolean"
                },
                "service-instances": {
                  "description": "Report service instances instead of the services types",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "suppress-modified-paths": {
              "description": "Do not report modified paths",
              "enum": [
                "without-instance-data",
                "without-affected-services",
                "all"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "all",
                "1": "without-affected-services",
                "2": "without-instance-data"
              }
            },
            "suppress-positive-result": {
              "description": "Only return result if some error occurred",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device-group__name",
            "__key__ned-id__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_ned_id_migrate"
      },
      {
        "description": "NSO Action: Set up sessions to all unlocked devices (path: /ncs:devices/device-group/connect)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            },
            "override-southbound-locked": {
              "description": "When a device is southbound locked, all southbound communication\nis turned off. This flag overrides this for connection\nattempts. Thus, this is a way to update the capabilities\nincluding revision information for a managed device although\nthe device is southbound locked",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Use this additional parameter to only return\ndevices that failed to connect.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__device-group__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_connect"
      },
      {
        "description": "NSO Action: Synchronize the config by pushing to the devices (path: /ncs:devices/device-group/sync-to)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "Report what would be done towards the device, without\nactually doing anything.",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "mode": {
              "description": "For NETCONF devices, replace the device configurations\nwith the NCS configurations, instead of sending the diff.\n\nCannot be used with non-NETCONF devices.",
              "enum": [
                "replace"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "replace"
              }
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Use this additional parameter to only return\ndevices that failed to sync.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device-group__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_sync_to"
      },
      {
        "description": "NSO Action: Synchronize the config by pulling from the devices (path: /ncs:devices/device-group/sync-from)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            },
            "confirm-network-state": {
              "description": "confirm-network-state",
              "properties": {
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "Report what would be done towards CDB, without\nactually doing anything.",
                  "enum": [
                    "cli-c",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Use this additional parameter to only return\ndevices that failed to sync.",
              "type": "boolean"
            },
            "verbose": {
              "description": "Use this to show additional parse information if supported\nby the NED.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device-group__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_sync_from"
      },
      {
        "description": "NSO Action: Close all sessions to the devices (path: /ncs:devices/device-group/disconnect)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device-group__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_disconnect"
      },
      {
        "description": "NSO Action: Check if the NCS config is in sync with the device (path: /ncs:devices/device-group/check-sync)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Use this additional parameter to only return\ndevices not in sync.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device-group__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_check_sync"
      },
      {
        "description": "NSO Action: Check if NCS and the devices have compatible YANG modules (path: /ncs:devices/device-group/check-yang-modules)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            },
            "suppress-positive-result": {
              "description": "Use this to only return devices that have incompatible\nmodules.",
              "type": "boolean"
            },
            "verbose": {
              "description": "Use this to show additional compatibility info.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__device-group__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_check_yang_modules"
      },
      {
        "description": "NSO Action: Retrieve SSH host keys from all devices (path: /ncs:devices/device-group/fetch-ssh-host-keys)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            },
            "suppress-fingerprints": {
              "description": "Do not return key fingerprints",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Only return result if key retrieval failed",
              "type": "boolean"
            },
            "suppress-unchanged-result": {
              "description": "Do not return result if keys are unchanged",
              "type": "boolean"
            }
          },
          "required": [
            "__key__device-group__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_fetch_ssh_host_keys"
      },
      {
        "description": "NSO Action: Take a named template and apply it here (path: /ncs:devices/device-group/apply-template)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            },
            "accept-empty-capabilities": {
              "description": "Apply template to devices with no capabilities known",
              "type": "boolean"
            },
            "comment": {
              "description": "A comment attached to any rollback file created as a result\nof the transaction. If supported, the comment will also\nbe propagated down to the device.",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "The error option to use. Depending on the selected error option\nNCS will store the reverse of the original transaction\nto be able to undo the transaction changes and get back to the\nprevious state. This data is stored in the\n/devices/commit-queue/completed tree from where it can\nbe viewed and invoked with the rollback action. When invoked\nthe data will be removed.",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "Unique id identifying a queue item. If locked, this\nitem will be unlocked in the commit phase.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "If this container is created, the commit will make a\nconfirm-network-state sync check on the participating devices.",
              "properties": {
                "compare": {
                  "description": "The scope of the confirm-network-state check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "Re-evaluate all saved extra-create-ops operations\nagainst the current set of out-of-band policies.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "label": {
              "description": "User defined label. The label is present in\nrollback files, notifications and events referencing\nthe transaction.",
              "type": "string"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "no-networking": {
              "description": "Do not send any data to the devices. Even if the transaction\nmanipulates data below /devices/device/config, nothing will\nbe sent to the managed devices. This is a way to manipulate\nCDB in NCS without generating any southbound traffic.",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that a device's\nconfiguration is out of sync. The device's sync state is assumed\nto be unknown after such commit and the stored transaction id\nvalue is cleared",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "This flag means that NCS will check that the modified data and\noptionally the data read when computing the device modifications\nhave not changed on the device compared to NCS's view of the data.\nValidating the data read when computing the device modifications\nis important because the read data might be a prerequisite to\nbeing able to write the data successfully; there might exist\nconstraints on the modified data (e.g., a 'must' statement) that\nare fulfilled in NCS but not on the device.\n\nThis is a fine-grained sync check; NCS verifies that NCS\nand the device are in sync regarding the data that will be\nmodified and optionally the data read when computing the device\nmodifications. If they are not in sync, the transaction is\naborted.",
              "properties": {
                "compare": {
                  "description": "The scope of the no-overwrite check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "This flag means that NCS will not run its data model revision\nalgorithm, which requires all participating managed devices\nto have all parts of the data models for all data contained\nin this transaction. Thus, this flag forces NCS to never\nsilently drop any data set operations towards a device.",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Only return result if some error occurred",
              "type": "boolean"
            },
            "template-name": {
              "description": "template-name",
              "type": "string"
            },
            "use-lsa": {
              "description": "Force handling of the LSA nodes as such. This flag tells\nNCS to propagate applicable commit flags and actions\nto the LSA nodes without applying them on the upper\nNCS node itself. The commit flags affected are\n'dry-run', 'no-networking', 'no-out-of-sync-check',\n'no-overwrite', 'no-revision-drop' and 'confirm-network-state'.",
              "type": "boolean"
            },
            "variable": {
              "description": "variable",
              "properties": {
                "name": {
                  "description": "name",
                  "type": "string"
                },
                "value": {
                  "description": "value",
                  "type": "string"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device-group__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_apply_template"
      },
      {
        "description": "NSO Action: Secure copy file to multiple devices (path: /ncs:devices/device-group/scp-to)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            },
            "local-file": {
              "description": "Name of the file in the local filesystem.",
              "type": "string"
            },
            "port": {
              "description": "Port to connect to on the device",
              "type": "integer"
            },
            "preserve": {
              "description": "Preserves modification times, access times, and modes\nfrom the original file. This is not always supported by the\ndevice.",
              "type": "boolean"
            },
            "protocol": {
              "description": "Protocol to use for file transfer - scp or sftp.",
              "enum": [
                "sftp",
                "scp"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "scp",
                "1": "sftp"
              }
            },
            "remote-file": {
              "description": "Name of the file on the device.",
              "type": "string"
            }
          },
          "required": [
            "__key__device-group__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_scp_to"
      },
      {
        "description": "NSO Action: Clear all trace files (path: /ncs:devices/device-group/clear-trace)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device-group__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_clear_trace"
      },
      {
        "description": "NSO Action: Add device members to the group. (path: /ncs:devices/device-group/add-member)",
        "inputSchema": {
          "properties": {
            "__key__device-group__name": {
              "description": "Key for 'device-group' list in action path - Key 'name' for list 'device-group'",
              "type": "string",
              "x-list-tag": "device-group",
              "x-path-key": true
            },
            "device-select": {
              "description": "Add devices selected by the XPath expression to the group.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            }
          },
          "required": [
            "__key__device-group__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_group_add_member"
      },
      {
        "description": "NSO Action: Show the fingerprint for the key (path: /ncs:devices/device/ssh/host-key/show-fingerprint)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "__key__host-key__algorithm": {
              "description": "Key for 'host-key' list in action path - Key 'algorithm' for list 'host-key'",
              "type": "string",
              "x-list-tag": "host-key",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name",
            "__key__host-key__algorithm"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_ssh_host_key_show_fingerprint"
      },
      {
        "description": "NSO Action: Retrieve host keys from remote (path: /ncs:devices/device/ssh/fetch-host-keys)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_ssh_fetch_host_keys"
      },
      {
        "description": "NSO Action: Show the fingerprint for the key (path: /ncs:devices/device/live-status-protocol/ssh/host-key/show-fingerprint)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "__key__host-key__algorithm": {
              "description": "Key for 'host-key' list in action path - Key 'algorithm' for list 'host-key'",
              "type": "string",
              "x-list-tag": "host-key",
              "x-path-key": true
            },
            "__key__live-status-protocol__name": {
              "description": "Key for 'live-status-protocol' list in action path - Key 'name' for list 'live-status-protocol'",
              "type": "string",
              "x-list-tag": "live-status-protocol",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name",
            "__key__live-status-protocol__name",
            "__key__host-key__algorithm"
          ],
          "type": "object"
        },
        "name": "ncs_devices_host_key_show_fingerprint"
      },
      {
        "description": "NSO Action: This action removes a capability from the list of capabilities.\nIf leaf module is set then corresponding module is attempted to\nbe removed from the list of modules for this device. This action\nis only intended to be used for pre-provisioning: it is not\npossible to override capabilities and modules provided by the\nNED implementation using this action. (path: /ncs:devices/device/capability/remove)",
        "inputSchema": {
          "properties": {
            "__key__capability__uri": {
              "description": "Key for 'capability' list in action path - Key 'uri' for list 'capability'",
              "type": "string",
              "x-list-tag": "capability",
              "x-path-key": true
            },
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name",
            "__key__capability__uri"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_capability_remove"
      },
      {
        "description": "NSO Action: Execute show commands (path: /ncs:devices/device/live-status/exec/show)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "args": {
              "description": "args (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_live_status_exec_show"
      },
      {
        "description": "NSO Action: Reset functions (path: /ncs:devices/device/live-status/exec/clear)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "args": {
              "description": "args (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_live_status_exec_clear"
      },
      {
        "description": "NSO Action: Register/deregister the product instance with the Cisco Licensing Authority (path: /ncs:devices/device/live-status/exec/license)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "args": {
              "description": "args (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_live_status_exec_license"
      },
      {
        "description": "NSO Action: Execute any command on device (path: /ncs:devices/device/live-status/exec/any)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "args": {
              "description": "args (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "auto-prompts": {
              "description": "auto-prompts",
              "properties": {
                "answer": {
                  "description": "answer",
                  "type": "string"
                },
                "question": {
                  "description": "question",
                  "type": "string"
                }
              },
              "type": "object"
            },
            "context": {
              "description": "Specify context to run the command in",
              "type": "string"
            },
            "input-string": {
              "description": "Input data to command, e.g. base 64 encoded pkcs12",
              "type": "string"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_live_status_exec_any"
      },
      {
        "description": "NSO Action: Send echo messages. DEPRECATED, use 'any' (path: /ncs:devices/device/live-status/exec/ping)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "args": {
              "description": "args (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "auto-prompts": {
              "description": "auto-prompts",
              "properties": {
                "answer": {
                  "description": "answer",
                  "type": "string"
                },
                "question": {
                  "description": "question",
                  "type": "string"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_live_status_exec_ping"
      },
      {
        "description": "NSO Action: Copy from one file to another. DEPRECATED, use 'any' (path: /ncs:devices/device/live-status/exec/copy)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "args": {
              "description": "args (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "auto-prompts": {
              "description": "auto-prompts",
              "properties": {
                "answer": {
                  "description": "answer",
                  "type": "string"
                },
                "question": {
                  "description": "question",
                  "type": "string"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_live_status_exec_copy"
      },
      {
        "description": "NSO Action: Halt and perform a cold restart. DEPRECATED, use 'any' (path: /ncs:devices/device/live-status/exec/reload)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "args": {
              "description": "args (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "auto-prompts": {
              "description": "auto-prompts",
              "properties": {
                "answer": {
                  "description": "answer",
                  "type": "string"
                },
                "question": {
                  "description": "question",
                  "type": "string"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_live_status_exec_reload"
      },
      {
        "description": "NSO Action: Trace route to destination. DEPRECATED, use 'any' (path: /ncs:devices/device/live-status/exec/traceroute)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "args": {
              "description": "args (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "auto-prompts": {
              "description": "auto-prompts",
              "properties": {
                "answer": {
                  "description": "answer",
                  "type": "string"
                },
                "question": {
                  "description": "question",
                  "type": "string"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_live_status_exec_traceroute"
      },
      {
        "description": "NSO Action: Verify a file. DEPRECATED, use 'any' (path: /ncs:devices/device/live-status/exec/verify)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "args": {
              "description": "args (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "auto-prompts": {
              "description": "auto-prompts",
              "properties": {
                "answer": {
                  "description": "answer",
                  "type": "string"
                },
                "question": {
                  "description": "question",
                  "type": "string"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_live_status_exec_verify"
      },
      {
        "description": "NSO Action: Execute any command(s) on device, nothing will be logged. See README for details (path: /ncs:devices/device/live-status/exec/any-hidden)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "args": {
              "description": "args",
              "type": "string"
            },
            "auto-prompts": {
              "description": "auto-prompts",
              "properties": {
                "answer": {
                  "description": "answer",
                  "type": "string"
                },
                "question": {
                  "description": "question",
                  "type": "string"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_live_status_exec_any_hidden"
      },
      {
        "description": "NSO Action: Encryption module (deprecated, use 'any') (path: /ncs:devices/device/live-status/exec/crypto)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "key": {
              "description": "Long term key operations",
              "items": {
                "type": "string"
              },
              "type": "array"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_live_status_exec_crypto"
      },
      {
        "description": "NSO Action: Attempt to reconnect this subscription (path: /ncs:devices/device/notifications/subscription/reconnect)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "__key__subscription__name": {
              "description": "Key for 'subscription' list in action path - Each subscription must have a unique name.",
              "type": "string",
              "x-list-tag": "subscription",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name",
            "__key__subscription__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_notifications_subscription_reconnect"
      },
      {
        "description": "NSO Action: Disconnect this subscription if connected (path: /ncs:devices/device/notifications/subscription/disconnect)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "__key__subscription__name": {
              "description": "Key for 'subscription' list in action path - Each subscription must have a unique name.",
              "type": "string",
              "x-list-tag": "subscription",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name",
            "__key__subscription__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_notifications_subscription_disconnect"
      },
      {
        "description": "NSO Action: Replay (missed) notifications from the device (path: /ncs:devices/device/notifications/subscription/replay)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "__key__subscription__name": {
              "description": "Key for 'subscription' list in action path - Each subscription must have a unique name.",
              "type": "string",
              "x-list-tag": "subscription",
              "x-path-key": true
            },
            "from-date-time": {
              "description": "from-date-time",
              "type": "string"
            }
          },
          "required": [
            "__key__device__name",
            "__key__subscription__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_notifications_subscription_replay"
      },
      {
        "description": "NSO Action: Delete all received notifications from the\n'notification' list. (path: /ncs:devices/device/notifications/received-notifications/clear)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_received_notifications_clear"
      },
      {
        "description": "NSO Action: Attempt to reconnect this subscription (path: /ncs:devices/device/telemetry/subscription/reconnect)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "__key__subscription__name": {
              "description": "Key for 'subscription' list in action path - Subscription name.",
              "type": "string",
              "x-list-tag": "subscription",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name",
            "__key__subscription__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_telemetry_subscription_reconnect"
      },
      {
        "description": "NSO Action: Disconnect this subscription if connected (path: /ncs:devices/device/telemetry/subscription/disconnect)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "__key__subscription__name": {
              "description": "Key for 'subscription' list in action path - Subscription name.",
              "type": "string",
              "x-list-tag": "subscription",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name",
            "__key__subscription__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_telemetry_subscription_disconnect"
      },
      {
        "description": "NSO Action: Check if device configuration is according to the service (path: /ncs:devices/device/services/service/check-sync)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "__key__service__id": {
              "description": "Key for 'service' list in action path - Service identifier",
              "type": "string",
              "x-list-tag": "service",
              "x-path-key": true
            },
            "deep": {
              "description": "deep",
              "type": "boolean"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "outformat": {
              "description": "outformat",
              "enum": [
                "cli-c",
                "boolean",
                "native",
                "xml",
                "cli"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "cli",
                "1": "xml",
                "2": "native",
                "3": "boolean",
                "4": "cli-c"
              }
            },
            "shallow": {
              "description": "shallow",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Return list only contains negatives",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "Force handling LSA nodes as such.",
              "type": "boolean"
            },
            "with-service-meta-data": {
              "description": "Include changes to service meta-data.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__device__name",
            "__key__service__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_services_service_check_sync"
      },
      {
        "description": "NSO Action: Mark the service as changed (path: /ncs:devices/device/services/service/touch)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "__key__service__id": {
              "description": "Key for 'service' list in action path - Service identifier",
              "type": "string",
              "x-list-tag": "service",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name",
            "__key__service__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_services_service_touch"
      },
      {
        "description": "NSO Action: Run/Dry-run the service logic again (path: /ncs:devices/device/services/service/re-deploy)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "__key__service__id": {
              "description": "Key for 'service' list in action path - Service identifier",
              "type": "string",
              "x-list-tag": "service",
              "x-path-key": true
            },
            "comment": {
              "description": "A comment attached to any rollback file created as a result\nof the transaction. If supported, the comment will also\nbe propagated down to the device.",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "The error option to use. Depending on the selected error option\nNCS will store the reverse of the original transaction\nto be able to undo the transaction changes and get back to the\nprevious state. This data is stored in the\n/devices/commit-queue/completed tree from where it can\nbe viewed and invoked with the rollback action. When invoked\nthe data will be removed.",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "Unique id identifying a queue item. If locked, this\nitem will be unlocked in the commit phase.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "If this container is created, the commit will make a\nconfirm-network-state sync check on the participating devices.",
              "properties": {
                "compare": {
                  "description": "The scope of the confirm-network-state check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "Re-evaluate all saved extra-create-ops operations\nagainst the current set of out-of-band policies.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "deep": {
              "description": "deep",
              "type": "boolean"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                },
                "with-service-meta-data": {
                  "description": "Include changes to service meta-data.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "label": {
              "description": "User defined label. The label is present in\nrollback files, notifications and events referencing\nthe transaction.",
              "type": "string"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "no-networking": {
              "description": "Do not send any data to the devices. Even if the transaction\nmanipulates data below /devices/device/config, nothing will\nbe sent to the managed devices. This is a way to manipulate\nCDB in NCS without generating any southbound traffic.",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that a device's\nconfiguration is out of sync. The device's sync state is assumed\nto be unknown after such commit and the stored transaction id\nvalue is cleared",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "This flag means that NCS will check that the modified data and\noptionally the data read when computing the device modifications\nhave not changed on the device compared to NCS's view of the data.\nValidating the data read when computing the device modifications\nis important because the read data might be a prerequisite to\nbeing able to write the data successfully; there might exist\nconstraints on the modified data (e.g., a 'must' statement) that\nare fulfilled in NCS but not on the device.\n\nThis is a fine-grained sync check; NCS verifies that NCS\nand the device are in sync regarding the data that will be\nmodified and optionally the data read when computing the device\nmodifications. If they are not in sync, the transaction is\naborted.",
              "properties": {
                "compare": {
                  "description": "The scope of the no-overwrite check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "This flag means that NCS will not run its data model revision\nalgorithm, which requires all participating managed devices\nto have all parts of the data models for all data contained\nin this transaction. Thus, this flag forces NCS to never\nsilently drop any data set operations towards a device.",
              "type": "boolean"
            },
            "reconcile": {
              "description": "Reconcile the service data. All data which existed before\nthe service was created will now be owned by the service.\nThe reference count will indicate how many services control\nthe data. When the service is removed that data will also be\nremoved. In technical terms the reference count will be\ndecreased by one for everything which existed prior to the\nservice.\n\nIf manually configured data exists below in the configuration\ntree that data is kept unless the option\n'discard-non-service-config' is used.\n\n'keep-non-service-config' will keep manually configured data by\nincreasing the refcounts and thereby store it as if it was\nexisting already before the service was created.\n\n'attach-non-service-config' will take data that otherwise\nwill exist also after the last service is deleted,\ndecrease the refcounts and instead store it as\nout-of-band data that is managed by the service.\nThis is similar to what a commit confirm-network-state would\ndo for detected out-of-band data.\n\n'detach-non-service-config' will take all out-of-band data that\nis managed by a service and instead increase the refcounts so\nthe data will exist also after the service is deleted. Similar\nto what a reconcile 'keep-non-service-config' would do.",
              "properties": {
                "attach-non-service-config": {
                  "description": "attach-non-service-config",
                  "type": "boolean"
                },
                "detach-non-service-config": {
                  "description": "detach-non-service-config",
                  "type": "boolean"
                },
                "discard-non-service-config": {
                  "description": "discard-non-service-config",
                  "type": "boolean"
                },
                "exclude": {
                  "description": "List of paths to be excluded in the reconciliation.",
                  "items": {
                    "type": "string"
                  },
                  "type": "array"
                },
                "include": {
                  "description": "List of paths to be included in the reconciliation.",
                  "items": {
                    "type": "string"
                  },
                  "type": "array"
                },
                "keep-non-service-config": {
                  "description": "keep-non-service-config",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "shallow": {
              "description": "shallow",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "Force handling of the LSA nodes as such. This flag tells\nNCS to propagate applicable commit flags and actions\nto the LSA nodes without applying them on the upper\nNCS node itself. The commit flags affected are\n'dry-run', 'no-networking', 'no-out-of-sync-check',\n'no-overwrite', 'no-revision-drop' and 'confirm-network-state'.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__device__name",
            "__key__service__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_services_service_re_deploy"
      },
      {
        "description": "NSO Action: Undo the effects of the service (path: /ncs:devices/device/services/service/un-deploy)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "__key__service__id": {
              "description": "Key for 'service' list in action path - Service identifier",
              "type": "string",
              "x-list-tag": "service",
              "x-path-key": true
            },
            "comment": {
              "description": "A comment attached to any rollback file created as a result\nof the transaction. If supported, the comment will also\nbe propagated down to the device.",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "The error option to use. Depending on the selected error option\nNCS will store the reverse of the original transaction\nto be able to undo the transaction changes and get back to the\nprevious state. This data is stored in the\n/devices/commit-queue/completed tree from where it can\nbe viewed and invoked with the rollback action. When invoked\nthe data will be removed.",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "Unique id identifying a queue item. If locked, this\nitem will be unlocked in the commit phase.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "If this container is created, the commit will make a\nconfirm-network-state sync check on the participating devices.",
              "properties": {
                "compare": {
                  "description": "The scope of the confirm-network-state check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "Re-evaluate all saved extra-create-ops operations\nagainst the current set of out-of-band policies.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                },
                "with-service-meta-data": {
                  "description": "Include changes to service meta-data.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "ignore-refcount": {
              "description": "Unconditionally delete the device data created by the\nservice, regardless of the refcount.",
              "type": "boolean"
            },
            "label": {
              "description": "User defined label. The label is present in\nrollback files, notifications and events referencing\nthe transaction.",
              "type": "string"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "no-networking": {
              "description": "Do not send any data to the devices. Even if the transaction\nmanipulates data below /devices/device/config, nothing will\nbe sent to the managed devices. This is a way to manipulate\nCDB in NCS without generating any southbound traffic.",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that a device's\nconfiguration is out of sync. The device's sync state is assumed\nto be unknown after such commit and the stored transaction id\nvalue is cleared",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "This flag means that NCS will check that the modified data and\noptionally the data read when computing the device modifications\nhave not changed on the device compared to NCS's view of the data.\nValidating the data read when computing the device modifications\nis important because the read data might be a prerequisite to\nbeing able to write the data successfully; there might exist\nconstraints on the modified data (e.g., a 'must' statement) that\nare fulfilled in NCS but not on the device.\n\nThis is a fine-grained sync check; NCS verifies that NCS\nand the device are in sync regarding the data that will be\nmodified and optionally the data read when computing the device\nmodifications. If they are not in sync, the transaction is\naborted.",
              "properties": {
                "compare": {
                  "description": "The scope of the no-overwrite check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "This flag means that NCS will not run its data model revision\nalgorithm, which requires all participating managed devices\nto have all parts of the data models for all data contained\nin this transaction. Thus, this flag forces NCS to never\nsilently drop any data set operations towards a device.",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "Force handling of the LSA nodes as such. This flag tells\nNCS to propagate applicable commit flags and actions\nto the LSA nodes without applying them on the upper\nNCS node itself. The commit flags affected are\n'dry-run', 'no-networking', 'no-out-of-sync-check',\n'no-overwrite', 'no-revision-drop' and 'confirm-network-state'.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__device__name",
            "__key__service__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_services_service_un_deploy"
      },
      {
        "description": "NSO Action: Migrate the device to a new NED type (path: /ncs:devices/device/migrate)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "dry-run": {
              "description": "Report what would be done without actually doing anything",
              "type": "boolean"
            },
            "new-ned-id": {
              "description": "The new NED Identity",
              "type": "string"
            },
            "no-networking": {
              "description": "Do not generate any southbound traffic towards the\nnetwork. Use the device configuration in CDB.",
              "type": "boolean"
            },
            "no-templates": {
              "description": "Do not automatically migrate device and compliance templates\nreferring to the old NED identity.",
              "type": "boolean"
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "report": {
              "description": "report",
              "properties": {
                "affected-templates": {
                  "description": "Report device and compliance templates",
                  "type": "boolean"
                },
                "all": {
                  "description": "Report all managed objects affected by the migration\n(very verbose)",
                  "type": "boolean"
                },
                "service-instances": {
                  "description": "Report service instances instead of the services types",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "suppress-modified-paths": {
              "description": "Do not report modified paths",
              "enum": [
                "without-instance-data",
                "without-affected-services",
                "all"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "all",
                "1": "without-affected-services",
                "2": "without-instance-data"
              }
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_migrate"
      },
      {
        "description": "NSO Action: Note: this action overwrites existing list of capabilities.\n\nThis action copies the list of capabilities and the list of modules\nfrom another device or profile. When used on a device, this action\nis only intended to be used for pre-provisioning: it is not possible\nto override capabilities and modules provided by the\nNED implementation using this action. (path: /ncs:devices/device/copy-capabilities)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "from-device": {
              "description": "from-device",
              "type": "string"
            },
            "from-profile": {
              "description": "from-profile",
              "type": "string"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_copy_capabilities"
      },
      {
        "description": "NSO Action: This action overwrites existing list of capabilities.\n\nThis action is only intended to be used for\npre-provisioning: it is not possible to override\ncapabilities and modules provided by the NED implementation\nusing this action.\n\nThis action populates the list of capabilities based on the\nconfigured ned-id for the device, if possible.  NCS will\nlook up the package corresponding to the ned-id and add all\nthe modules from these packages to the list of device\ncapabilities and list of modules.  It is the responsibility\nof the caller to verify that the automatically populated\nlist of capabilities matches actual device capabilities.\nThe list of capabilities can then be fine-tuned using\nadd-capability and capability/remove actions.\n\nCurrently this approach works only for CLI and generic\ndevices. (path: /ncs:devices/device/find-capabilities)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_find_capabilities"
      },
      {
        "description": "NSO Action: This action adds a capability to the list of capabilities.\n\nThis action is only intended to be used for\npre-provisioning.  It is not possible to override\ncapabilities and modules provided by the NED implementation\nusing this action.\n\nIf a uri is specified, then it is parsed as a YANG\ncapability string, and module, revision, feature and\ndeviation parameters are derived from the string.\n\nIf a module is specified, then the namespace is looked up\nin the list of loaded namespaces and a capability string is\nconstructed automatically.  If a module is specified and\nthe attempt to look it up failed, then the action does\nnothing.\n\nIf a module is specified or can be derived from the\ncapability string, then the module is also added/replaced\nin the list of modules. (path: /ncs:devices/device/add-capability)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "deviation": {
              "description": "deviation (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "feature": {
              "description": "feature (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "module": {
              "description": "module",
              "type": "string"
            },
            "ned-id": {
              "description": "ned-id",
              "type": "string"
            },
            "revision": {
              "description": "revision",
              "type": "string"
            },
            "uri": {
              "description": "uri",
              "type": "string"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_add_capability"
      },
      {
        "description": "NSO Action: Take a named template and apply it here (path: /ncs:devices/device/apply-template)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "accept-empty-capabilities": {
              "description": "Apply template to devices with no capabilities known",
              "type": "boolean"
            },
            "comment": {
              "description": "A comment attached to any rollback file created as a result\nof the transaction. If supported, the comment will also\nbe propagated down to the device.",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "The error option to use. Depending on the selected error option\nNCS will store the reverse of the original transaction\nto be able to undo the transaction changes and get back to the\nprevious state. This data is stored in the\n/devices/commit-queue/completed tree from where it can\nbe viewed and invoked with the rollback action. When invoked\nthe data will be removed.",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "Unique id identifying a queue item. If locked, this\nitem will be unlocked in the commit phase.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "If this container is created, the commit will make a\nconfirm-network-state sync check on the participating devices.",
              "properties": {
                "compare": {
                  "description": "The scope of the confirm-network-state check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "Re-evaluate all saved extra-create-ops operations\nagainst the current set of out-of-band policies.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "label": {
              "description": "User defined label. The label is present in\nrollback files, notifications and events referencing\nthe transaction.",
              "type": "string"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "no-networking": {
              "description": "Do not send any data to the devices. Even if the transaction\nmanipulates data below /devices/device/config, nothing will\nbe sent to the managed devices. This is a way to manipulate\nCDB in NCS without generating any southbound traffic.",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that a device's\nconfiguration is out of sync. The device's sync state is assumed\nto be unknown after such commit and the stored transaction id\nvalue is cleared",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "This flag means that NCS will check that the modified data and\noptionally the data read when computing the device modifications\nhave not changed on the device compared to NCS's view of the data.\nValidating the data read when computing the device modifications\nis important because the read data might be a prerequisite to\nbeing able to write the data successfully; there might exist\nconstraints on the modified data (e.g., a 'must' statement) that\nare fulfilled in NCS but not on the device.\n\nThis is a fine-grained sync check; NCS verifies that NCS\nand the device are in sync regarding the data that will be\nmodified and optionally the data read when computing the device\nmodifications. If they are not in sync, the transaction is\naborted.",
              "properties": {
                "compare": {
                  "description": "The scope of the no-overwrite check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "This flag means that NCS will not run its data model revision\nalgorithm, which requires all participating managed devices\nto have all parts of the data models for all data contained\nin this transaction. Thus, this flag forces NCS to never\nsilently drop any data set operations towards a device.",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Only return result if some error occurred",
              "type": "boolean"
            },
            "template-name": {
              "description": "template-name",
              "type": "string"
            },
            "use-lsa": {
              "description": "Force handling of the LSA nodes as such. This flag tells\nNCS to propagate applicable commit flags and actions\nto the LSA nodes without applying them on the upper\nNCS node itself. The commit flags affected are\n'dry-run', 'no-networking', 'no-out-of-sync-check',\n'no-overwrite', 'no-revision-drop' and 'confirm-network-state'.",
              "type": "boolean"
            },
            "variable": {
              "description": "variable",
              "properties": {
                "name": {
                  "description": "name",
                  "type": "string"
                },
                "value": {
                  "description": "value",
                  "type": "string"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_apply_template"
      },
      {
        "description": "NSO Action: Instantiate the config for the device from existing device (path: /ncs:devices/device/instantiate-from-other-device)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "device-name": {
              "description": "device-name",
              "type": "string"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_instantiate_from_other_device"
      },
      {
        "description": "NSO Action: Compare the actual device config with the NCS copy (path: /ncs:devices/device/compare-config)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "outformat": {
              "description": "outformat",
              "enum": [
                "cli-c",
                "xml",
                "cli"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "cli",
                "1": "xml",
                "4": "cli-c"
              }
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_compare_config"
      },
      {
        "description": "NSO Action: Synchronize the config by pulling from the device (path: /ncs:devices/device/sync-from)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "confirm-network-state": {
              "description": "confirm-network-state",
              "properties": {
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "Report what would be done towards CDB, without\nactually doing anything.",
                  "enum": [
                    "cli-c",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "verbose": {
              "description": "Use this to show additional parse information if supported\nby the NED.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_sync_from"
      },
      {
        "description": "NSO Action: Synchronize the config by pushing to the device (path: /ncs:devices/device/sync-to)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "Report what would be done towards the device, without\nactually doing anything.",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "mode": {
              "description": "DEPRECATED - use sync-to default behaviour instead",
              "enum": [
                "replace"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "replace"
              }
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_sync_to"
      },
      {
        "description": "NSO Action: Check if the NCS config is in sync with the device (path: /ncs:devices/device/check-sync)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_check_sync"
      },
      {
        "description": "NSO Action: Check if NCS and the device have compatible YANG modules (path: /ncs:devices/device/check-yang-modules)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "verbose": {
              "description": "Use this to show additional compatibility info.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_check_yang_modules"
      },
      {
        "description": "NSO Action: Connect to the device (path: /ncs:devices/device/connect)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "override-southbound-locked": {
              "description": "When a device is southbound locked, all southbound\ncommunication is turned off. This flag overrides the\nsouthbound lock for connection attempts. Thus, this\nis a way to update the capabilities including revision\ninformation for a managed device although the device\nis southbound locked.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_connect"
      },
      {
        "description": "NSO Action: Close all sessions to the device (path: /ncs:devices/device/disconnect)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_disconnect"
      },
      {
        "description": "NSO Action: ICMP ping the device (path: /ncs:devices/device/ping)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_ping"
      },
      {
        "description": "NSO Action: Delete the config in NCS without deleting it on the device (path: /ncs:devices/device/delete-config)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "force": {
              "description": "Force delete the device config.",
              "type": "boolean"
            },
            "ned-id": {
              "description": "The NED Identity for which configuration will be\ndeleted",
              "type": "string"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_delete_config"
      },
      {
        "description": "NSO Action: Secure copy file to the device (path: /ncs:devices/device/scp-to)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "local-file": {
              "description": "Name of the file in the local filesystem.",
              "type": "string"
            },
            "port": {
              "description": "Port to connect to on the device",
              "type": "integer"
            },
            "preserve": {
              "description": "Preserves modification times, access times, and modes\nfrom the original file. This is not always supported by the\ndevice.",
              "type": "boolean"
            },
            "protocol": {
              "description": "Protocol to use for file transfer - scp or sftp.",
              "enum": [
                "sftp",
                "scp"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "scp",
                "1": "sftp"
              }
            },
            "remote-file": {
              "description": "Name of the file on the device.",
              "type": "string"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_scp_to"
      },
      {
        "description": "NSO Action: Secure copy file to the device (path: /ncs:devices/device/scp-from)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "local-file": {
              "description": "Name of the file in the local filesystem.",
              "type": "string"
            },
            "port": {
              "description": "Port to connect to on the device",
              "type": "integer"
            },
            "preserve": {
              "description": "Preserves modification times, access times, and modes\nfrom the original file. This is not always supported by the\ndevice.",
              "type": "boolean"
            },
            "protocol": {
              "description": "Protocol to use for file transfer - scp or sftp.",
              "enum": [
                "sftp",
                "scp"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "scp",
                "1": "sftp"
              }
            },
            "remote-file": {
              "description": "Name of the file on the device.",
              "type": "string"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_scp_from"
      },
      {
        "description": "NSO Action: Rename this device (path: /ncs:devices/device/rename)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "new-name": {
              "description": "new-name",
              "type": "string"
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_rename"
      },
      {
        "description": "NSO Action: Load configuration data in native format (path: /ncs:devices/device/load-native-config)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            },
            "comment": {
              "description": "A comment attached to any rollback file created as a result\nof the transaction. If supported, the comment will also\nbe propagated down to the device.",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "The error option to use. Depending on the selected error option\nNCS will store the reverse of the original transaction\nto be able to undo the transaction changes and get back to the\nprevious state. This data is stored in the\n/devices/commit-queue/completed tree from where it can\nbe viewed and invoked with the rollback action. When invoked\nthe data will be removed.",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "Unique id identifying a queue item. If locked, this\nitem will be unlocked in the commit phase.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "If this container is created, the commit will make a\nconfirm-network-state sync check on the participating devices.",
              "properties": {
                "compare": {
                  "description": "The scope of the confirm-network-state check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "Re-evaluate all saved extra-create-ops operations\nagainst the current set of out-of-band policies.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "data": {
              "description": "Configuration data in native format. If loading\nXML the data must be a valid XML document,\neither with a single namespace or wrapped in a\nconfig node with the http://tail-f.com/ns/config/1.0\nnamespace.",
              "type": "string"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "file": {
              "description": "Name of file with configuration data in native format\nin the local filesystem. If the device is remote\nthe file must exists in the local filesystem of the\nremote node.",
              "type": "string"
            },
            "label": {
              "description": "User defined label. The label is present in\nrollback files, notifications and events referencing\nthe transaction.",
              "type": "string"
            },
            "mode": {
              "description": "Merge or replace the configuration. The default behaviour\nis to merge.",
              "enum": [
                "replace",
                "merge"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "merge",
                "1": "replace"
              }
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "no-networking": {
              "description": "Do not send any data to the devices. Even if the transaction\nmanipulates data below /devices/device/config, nothing will\nbe sent to the managed devices. This is a way to manipulate\nCDB in NCS without generating any southbound traffic.",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that a device's\nconfiguration is out of sync. The device's sync state is assumed\nto be unknown after such commit and the stored transaction id\nvalue is cleared",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "This flag means that NCS will check that the modified data and\noptionally the data read when computing the device modifications\nhave not changed on the device compared to NCS's view of the data.\nValidating the data read when computing the device modifications\nis important because the read data might be a prerequisite to\nbeing able to write the data successfully; there might exist\nconstraints on the modified data (e.g., a 'must' statement) that\nare fulfilled in NCS but not on the device.\n\nThis is a fine-grained sync check; NCS verifies that NCS\nand the device are in sync regarding the data that will be\nmodified and optionally the data read when computing the device\nmodifications. If they are not in sync, the transaction is\naborted.",
              "properties": {
                "compare": {
                  "description": "The scope of the no-overwrite check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "This flag means that NCS will not run its data model revision\nalgorithm, which requires all participating managed devices\nto have all parts of the data models for all data contained\nin this transaction. Thus, this flag forces NCS to never\nsilently drop any data set operations towards a device.",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "Force handling of the LSA nodes as such. This flag tells\nNCS to propagate applicable commit flags and actions\nto the LSA nodes without applying them on the upper\nNCS node itself. The commit flags affected are\n'dry-run', 'no-networking', 'no-out-of-sync-check',\n'no-overwrite', 'no-revision-drop' and 'confirm-network-state'.",
              "type": "boolean"
            },
            "verbose": {
              "description": "Use this to show additional parse information if supported\nby the NED.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_load_native_config"
      },
      {
        "description": "NSO Action: Clear the trace file for this device (path: /ncs:devices/device/clear-trace)",
        "inputSchema": {
          "properties": {
            "__key__device__name": {
              "description": "Key for 'device' list in action path - A string uniquely identifying the managed device",
              "type": "string",
              "x-list-tag": "device",
              "x-path-key": true
            }
          },
          "required": [
            "__key__device__name"
          ],
          "type": "object"
        },
        "name": "ncs_devices_device_clear_trace"
      },
      {
        "description": "NSO Action: Delete this queue item (path: /ncs:devices/commit-queue/queue-item/delete)",
        "inputSchema": {
          "properties": {
            "__key__queue-item__id": {
              "description": "Key for 'queue-item' list in action path - Unique id identifying a queue item.",
              "type": "integer",
              "x-list-tag": "queue-item",
              "x-path-key": true
            },
            "force": {
              "description": "Will brutally kill an ongoing commit. This could\nleave the devices in a bad state. If used on a sentinel,\nit allows to delete a lock taken by the system, however\ndeleting such a lock will result in unpredictable behaviour\nsince actions that are normally not allowed to run in\nparallel will be able to do that.\nIt is not recommended in any normal use case.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__queue-item__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_queue_item_delete"
      },
      {
        "description": "NSO Action: Put a lock on this queue item. This can only be performed\nwhen the queue item has status 'waiting' or 'blocked'.\nA lock can also be placed on a queue-item at commit time\nthrough the commit parameter 'commit-queue/lock'. (path: /ncs:devices/commit-queue/queue-item/lock)",
        "inputSchema": {
          "properties": {
            "__key__queue-item__id": {
              "description": "Key for 'queue-item' list in action path - Unique id identifying a queue item.",
              "type": "integer",
              "x-list-tag": "queue-item",
              "x-path-key": true
            }
          },
          "required": [
            "__key__queue-item__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_queue_item_lock"
      },
      {
        "description": "NSO Action: Unlock this queue item. For a queue item with status 'locked'\nthe status will change to 'waiting', for all other statuses this\naction is ignored. (path: /ncs:devices/commit-queue/queue-item/unlock)",
        "inputSchema": {
          "properties": {
            "__key__queue-item__id": {
              "description": "Key for 'queue-item' list in action path - Unique id identifying a queue item.",
              "type": "integer",
              "x-list-tag": "queue-item",
              "x-path-key": true
            },
            "atomic": {
              "description": "atomic",
              "type": "boolean"
            }
          },
          "required": [
            "__key__queue-item__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_queue_item_unlock"
      },
      {
        "description": "NSO Action: Prune a queue item (path: /ncs:devices/commit-queue/queue-item/prune)",
        "inputSchema": {
          "properties": {
            "__key__queue-item__id": {
              "description": "Key for 'queue-item' list in action path - Unique id identifying a queue item.",
              "type": "integer",
              "x-list-tag": "queue-item",
              "x-path-key": true
            },
            "device": {
              "description": "device (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "force": {
              "description": "Will brutally kill an ongoing commit. This could\nleave the devices in a bad state. It is not recommended\nin any normal use case.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__queue-item__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_queue_item_prune"
      },
      {
        "description": "NSO Action: Set the atomic behaviour of this queue item (path: /ncs:devices/commit-queue/queue-item/set-atomic-behaviour)",
        "inputSchema": {
          "properties": {
            "__key__queue-item__id": {
              "description": "Key for 'queue-item' list in action path - Unique id identifying a queue item.",
              "type": "integer",
              "x-list-tag": "queue-item",
              "x-path-key": true
            },
            "atomic": {
              "description": "atomic",
              "type": "boolean"
            }
          },
          "required": [
            "__key__queue-item__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_queue_item_set_atomic_behaviour"
      },
      {
        "description": "NSO Action: Retry devices with transient errors (path: /ncs:devices/commit-queue/queue-item/retry)",
        "inputSchema": {
          "properties": {
            "__key__queue-item__id": {
              "description": "Key for 'queue-item' list in action path - Unique id identifying a queue item.",
              "type": "integer",
              "x-list-tag": "queue-item",
              "x-path-key": true
            },
            "device": {
              "description": "device (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            }
          },
          "required": [
            "__key__queue-item__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_queue_item_retry"
      },
      {
        "description": "NSO Action: Wait for the queue item to be completed (path: /ncs:devices/commit-queue/queue-item/wait-until-completed)",
        "inputSchema": {
          "properties": {
            "__key__queue-item__id": {
              "description": "Key for 'queue-item' list in action path - Unique id identifying a queue item.",
              "type": "integer",
              "x-list-tag": "queue-item",
              "x-path-key": true
            },
            "infinity": {
              "description": "infinity",
              "type": "boolean"
            },
            "timeout": {
              "description": "timeout",
              "type": "integer"
            }
          },
          "required": [
            "__key__queue-item__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_queue_item_wait_until_completed"
      },
      {
        "description": "NSO Action: Rollback the original configuration data. (path: /ncs:devices/commit-queue/completed/queue-item/rollback)",
        "inputSchema": {
          "properties": {
            "__key__queue-item__id": {
              "description": "Key for 'queue-item' list in action path - Unique id identifying a queue item.",
              "type": "integer",
              "x-list-tag": "queue-item",
              "x-path-key": true
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that\na device's configuration is out of sync. The device's\nsync state is assumed to be unknown after such commit\nand the stored transaction id value is cleared",
              "type": "boolean"
            }
          },
          "required": [
            "__key__queue-item__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_completed_queue_item_rollback"
      },
      {
        "description": "NSO Action: Delete this queue item. (path: /ncs:devices/commit-queue/completed/queue-item/delete)",
        "inputSchema": {
          "properties": {
            "__key__queue-item__id": {
              "description": "Key for 'queue-item' list in action path - Unique id identifying a queue item.",
              "type": "integer",
              "x-list-tag": "queue-item",
              "x-path-key": true
            }
          },
          "required": [
            "__key__queue-item__id"
          ],
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_completed_queue_item_delete"
      },
      {
        "description": "NSO Action: Remove completed queue items (path: /ncs:devices/commit-queue/completed/purge)",
        "inputSchema": {
          "properties": {
            "older-than": {
              "description": "Matches the 'when' leaf in the queue item.",
              "properties": {
                "days": {
                  "description": "days",
                  "type": "integer"
                },
                "hours": {
                  "description": "hours",
                  "type": "integer"
                },
                "minutes": {
                  "description": "minutes",
                  "type": "integer"
                },
                "seconds": {
                  "description": "seconds",
                  "type": "integer"
                },
                "weeks": {
                  "description": "weeks",
                  "type": "integer"
                }
              },
              "type": "object"
            },
            "status": {
              "description": "status",
              "enum": [
                "failed",
                "deleted",
                "completed"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "completed",
                "1": "deleted",
                "2": "failed"
              }
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_completed_purge"
      },
      {
        "description": "NSO Action: Clear the entire queue (path: /ncs:devices/commit-queue/clear)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_clear"
      },
      {
        "description": "NSO Action: Prune portions of all queue items in the queue (path: /ncs:devices/commit-queue/prune)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "device (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "force": {
              "description": "Will brutally kill an ongoing commit. This could\nleave the devices in a bad state. It is not recommended in\nany normal use case.",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_prune"
      },
      {
        "description": "NSO Action: Set the atomic behaviour of all queue items (path: /ncs:devices/commit-queue/set-atomic-behaviour)",
        "inputSchema": {
          "properties": {
            "atomic": {
              "description": "atomic",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_set_atomic_behaviour"
      },
      {
        "description": "NSO Action: Wait for the commit queue to become empty (path: /ncs:devices/commit-queue/wait-until-empty)",
        "inputSchema": {
          "properties": {
            "infinity": {
              "description": "infinity",
              "type": "boolean"
            },
            "timeout": {
              "description": "timeout",
              "type": "integer"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_wait_until_empty"
      },
      {
        "description": "NSO Action: Add a lock for devices in the queue (path: /ncs:devices/commit-queue/add-lock)",
        "inputSchema": {
          "properties": {
            "async": {
              "description": "Add the lock asynchronously to the commit queue",
              "type": "boolean"
            },
            "block-others": {
              "description": "The lock will block other items, using any of the devices\nin the lock, to enter the commit queue.",
              "type": "boolean"
            },
            "device": {
              "description": "device (array of LIST)",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "label": {
              "description": "User defined label.\nThe label is present in all notifications and events\nsent referencing the specific queue item.",
              "type": "string"
            },
            "sync": {
              "description": "Add the lock synchronously. Block until the lock\nhas been successfully placed in the commit queue and\nno other queue items, using any of the devices, are\nahead in the queue.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the transaction to be committed.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_commit_queue_add_lock"
      },
      {
        "description": "NSO Action: Close pooled sessions for this device (path: /ncs:devices/session-pool/pooled-device/close)",
        "inputSchema": {
          "properties": {
            "__key__pooled-device__device": {
              "description": "Key for 'pooled-device' list in action path - Name of the device.",
              "type": "string",
              "x-list-tag": "pooled-device",
              "x-path-key": true
            }
          },
          "required": [
            "__key__pooled-device__device"
          ],
          "type": "object"
        },
        "name": "ncs_devices_session_pool_pooled_device_close"
      },
      {
        "description": "NSO Action: Close all sessions in the session pool (path: /ncs:devices/session-pool/close)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_devices_session_pool_close"
      },
      {
        "description": "NSO Action: Set up sessions to all unlocked devices (path: /ncs:devices/connect)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Apply the action to these devices.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Apply the action to the device group members.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-select": {
              "description": "Apply the action to the devices selected by the XPath expression.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            },
            "override-southbound-locked": {
              "description": "When a device is southbound locked, all southbound communication\nis turned off. This flag overrides this for connection\nattempts. Thus, this is a way to update the capabilities\nincluding revision information for a managed device although\nthe device is southbound locked",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Use this additional parameter to only return\ndevices that failed to connect.",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_connect"
      },
      {
        "description": "NSO Action: Synchronize the config by pushing to the devices (path: /ncs:devices/sync-to)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Apply the action to these devices.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Apply the action to the device group members.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-select": {
              "description": "Apply the action to the devices selected by the XPath expression.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "Report what would be done towards the device, without\nactually doing anything.",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "mode": {
              "description": "For NETCONF devices, replace the device configurations\nwith the NCS configurations, instead of sending the diff.\n\nCannot be used with non-NETCONF devices.",
              "enum": [
                "replace"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "replace"
              }
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Use this additional parameter to only return\ndevices that failed to sync.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_sync_to"
      },
      {
        "description": "NSO Action: Synchronize the config by pulling from the devices (path: /ncs:devices/sync-from)",
        "inputSchema": {
          "properties": {
            "confirm-network-state": {
              "description": "confirm-network-state",
              "properties": {
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "device": {
              "description": "Apply the action to these devices.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Apply the action to the device group members.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-select": {
              "description": "Apply the action to the devices selected by the XPath expression.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "Report what would be done towards CDB, without\nactually doing anything.",
                  "enum": [
                    "cli-c",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Use this additional parameter to only return\ndevices that failed to sync.",
              "type": "boolean"
            },
            "verbose": {
              "description": "Use this to show additional parse information if supported\nby the NED.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_sync_from"
      },
      {
        "description": "NSO Action: Close all sessions to the devices (path: /ncs:devices/disconnect)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Apply the action to these devices.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Apply the action to the device group members.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-select": {
              "description": "Apply the action to the devices selected by the XPath expression.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_disconnect"
      },
      {
        "description": "NSO Action: Check if the NCS config is in sync with the device (path: /ncs:devices/check-sync)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Apply the action to these devices.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Apply the action to the device group members.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-select": {
              "description": "Apply the action to the devices selected by the XPath expression.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Use this additional parameter to only return\ndevices not in sync.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_check_sync"
      },
      {
        "description": "NSO Action: Check if NCS and the devices have compatible YANG modules (path: /ncs:devices/check-yang-modules)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Apply the action to these devices.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Apply the action to the device group members.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-select": {
              "description": "Apply the action to the devices selected by the XPath expression.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            },
            "suppress-positive-result": {
              "description": "Use this to only return devices that have incompatible\nmodules.",
              "type": "boolean"
            },
            "verbose": {
              "description": "Use this to show additional compatibility info.",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_check_yang_modules"
      },
      {
        "description": "NSO Action: Retrieve SSH host keys from all devices (path: /ncs:devices/fetch-ssh-host-keys)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Apply the action to these devices.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Apply the action to the device group members.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-select": {
              "description": "Apply the action to the devices selected by the XPath expression.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            },
            "suppress-fingerprints": {
              "description": "Do not return key fingerprints",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Only return result if key retrieval failed",
              "type": "boolean"
            },
            "suppress-unchanged-result": {
              "description": "Do not return result if keys are unchanged",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_fetch_ssh_host_keys"
      },
      {
        "description": "NSO Action: Migrate the devices to a new NED type (path: /ncs:devices/migrate)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Apply the action to these devices.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Apply the action to the device group members.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-select": {
              "description": "Apply the action to the devices selected by the XPath expression.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            },
            "dry-run": {
              "description": "Report what would be done without actually doing anything",
              "type": "boolean"
            },
            "new-ned-id": {
              "description": "The new NED Identity",
              "type": "string"
            },
            "no-networking": {
              "description": "Do not generate any southbound traffic towards the\nnetwork. Use the device configuration in CDB.",
              "type": "boolean"
            },
            "no-templates": {
              "description": "Do not automatically migrate device and compliance templates\nreferring to the old NED identity.",
              "type": "boolean"
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "old-ned-id": {
              "description": "Only migrate devices with this NED identity",
              "type": "string"
            },
            "report": {
              "description": "report",
              "properties": {
                "affected-devices": {
                  "description": "Report affected devices",
                  "type": "boolean"
                },
                "affected-templates": {
                  "description": "Report device and compliance templates",
                  "type": "boolean"
                },
                "all": {
                  "description": "Report all managed objects affected by the migration\n(very verbose)",
                  "type": "boolean"
                },
                "service-instances": {
                  "description": "Report service instances instead of the services types",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "suppress-modified-paths": {
              "description": "Do not report modified paths",
              "enum": [
                "without-instance-data",
                "without-affected-services",
                "all"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "all",
                "1": "without-affected-services",
                "2": "without-instance-data"
              }
            },
            "suppress-positive-result": {
              "description": "Only return result if some error occurred",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_migrate"
      },
      {
        "description": "NSO Action: Take a named template and apply it here (path: /ncs:devices/apply-template)",
        "inputSchema": {
          "properties": {
            "accept-empty-capabilities": {
              "description": "Apply template to devices with no capabilities known",
              "type": "boolean"
            },
            "comment": {
              "description": "A comment attached to any rollback file created as a result\nof the transaction. If supported, the comment will also\nbe propagated down to the device.",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "The error option to use. Depending on the selected error option\nNCS will store the reverse of the original transaction\nto be able to undo the transaction changes and get back to the\nprevious state. This data is stored in the\n/devices/commit-queue/completed tree from where it can\nbe viewed and invoked with the rollback action. When invoked\nthe data will be removed.",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "Unique id identifying a queue item. If locked, this\nitem will be unlocked in the commit phase.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "If this container is created, the commit will make a\nconfirm-network-state sync check on the participating devices.",
              "properties": {
                "compare": {
                  "description": "The scope of the confirm-network-state check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "Re-evaluate all saved extra-create-ops operations\nagainst the current set of out-of-band policies.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "device": {
              "description": "Apply the action to these devices.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Apply the action to the device group members.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-select": {
              "description": "Apply the action to the devices selected by the XPath expression.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "label": {
              "description": "User defined label. The label is present in\nrollback files, notifications and events referencing\nthe transaction.",
              "type": "string"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "no-networking": {
              "description": "Do not send any data to the devices. Even if the transaction\nmanipulates data below /devices/device/config, nothing will\nbe sent to the managed devices. This is a way to manipulate\nCDB in NCS without generating any southbound traffic.",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that a device's\nconfiguration is out of sync. The device's sync state is assumed\nto be unknown after such commit and the stored transaction id\nvalue is cleared",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "This flag means that NCS will check that the modified data and\noptionally the data read when computing the device modifications\nhave not changed on the device compared to NCS's view of the data.\nValidating the data read when computing the device modifications\nis important because the read data might be a prerequisite to\nbeing able to write the data successfully; there might exist\nconstraints on the modified data (e.g., a 'must' statement) that\nare fulfilled in NCS but not on the device.\n\nThis is a fine-grained sync check; NCS verifies that NCS\nand the device are in sync regarding the data that will be\nmodified and optionally the data read when computing the device\nmodifications. If they are not in sync, the transaction is\naborted.",
              "properties": {
                "compare": {
                  "description": "The scope of the no-overwrite check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "This flag means that NCS will not run its data model revision\nalgorithm, which requires all participating managed devices\nto have all parts of the data models for all data contained\nin this transaction. Thus, this flag forces NCS to never\nsilently drop any data set operations towards a device.",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Only return result if some error occurred",
              "type": "boolean"
            },
            "template-name": {
              "description": "template-name",
              "type": "string"
            },
            "use-lsa": {
              "description": "Force handling of the LSA nodes as such. This flag tells\nNCS to propagate applicable commit flags and actions\nto the LSA nodes without applying them on the upper\nNCS node itself. The commit flags affected are\n'dry-run', 'no-networking', 'no-out-of-sync-check',\n'no-overwrite', 'no-revision-drop' and 'confirm-network-state'.",
              "type": "boolean"
            },
            "variable": {
              "description": "variable",
              "properties": {
                "name": {
                  "description": "name",
                  "type": "string"
                },
                "value": {
                  "description": "value",
                  "type": "string"
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_apply_template"
      },
      {
        "description": "NSO Action: Secure copy file to multiple devices (path: /ncs:devices/scp-to)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Apply the action to these devices.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Apply the action to the device group members.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-select": {
              "description": "Apply the action to the devices selected by the XPath expression.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            },
            "local-file": {
              "description": "Name of the file in the local filesystem.",
              "type": "string"
            },
            "port": {
              "description": "Port to connect to on the device",
              "type": "integer"
            },
            "preserve": {
              "description": "Preserves modification times, access times, and modes\nfrom the original file. This is not always supported by the\ndevice.",
              "type": "boolean"
            },
            "protocol": {
              "description": "Protocol to use for file transfer - scp or sftp.",
              "enum": [
                "sftp",
                "scp"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "scp",
                "1": "sftp"
              }
            },
            "remote-file": {
              "description": "Name of the file on the device.",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_scp_to"
      },
      {
        "description": "NSO Action: Clear all trace files (path: /ncs:devices/clear-trace)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Apply the action to these devices.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Apply the action to the device group members.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-select": {
              "description": "Apply the action to the devices selected by the XPath expression.\n\nThe XPath expression is either a location path or an\nexpression evaluated as a predicate to the\n/devices/device list.",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_clear_trace"
      },
      {
        "description": "NSO Action: Synchronize parts of the config by pushing to the device (path: /ncs:devices/partial-sync-to)",
        "inputSchema": {
          "properties": {
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "Report what would be done towards the device, without\nactually doing anything.",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "path": {
              "description": "A list of paths to push. Any path pointing to a subtree outside\n/devices/device/config will be ignored.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "suppress-positive-result": {
              "description": "Use this additional parameter to only return\ndevices that failed to sync.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_partial_sync_to"
      },
      {
        "description": "NSO Action: Synchronize parts of the devices' configuration by pulling from\nthe network.\n\nIf the wait-for-lock parameter is not given, the wait-for-lock\ndevice setting is going to be used. (path: /ncs:devices/partial-sync-from)",
        "inputSchema": {
          "properties": {
            "confirm-network-state": {
              "description": "confirm-network-state",
              "properties": {
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "Report what would be done towards CDB, without\nactually doing anything.",
                  "enum": [
                    "cli-c",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            },
            "no-wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies that the action should not wait for device lock,\ninstead, it should immediately fail if the device is being locked.",
              "type": "boolean"
            },
            "path": {
              "description": "A list of paths to fetch. Any path pointing to a subtree outside\n/devices/device/config will be ignored.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "suppress-positive-result": {
              "description": "Use this additional parameter to only return\ndevices that failed to sync.",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "The action can't be performed while the device is being\ncommitted to (or waiting in the commit queue). This is to avoid\ngetting inconsistent data when reading the configuration.\nThis specifies a timeout to wait for a device lock to be placed\nin the commit queue. The lock will be automatically released once\nthe action has been executed.",
              "properties": {
                "infinity": {
                  "description": "Wait infinitely for the lock, this is the default.",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "Specifies a maximum number of seconds to wait for the\ndevice to be locked.",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "ncs_devices_partial_sync_from"
      },
      {
        "description": "NSO Action: Create a device template from existing configuration. (path: /ncs:devices/create-template)",
        "inputSchema": {
          "properties": {
            "collapse-list-keys": {
              "description": "Collapse list keys into a single entry. The key\nwill be made into a variable.",
              "properties": {
                "all": {
                  "description": "All list keys will be made into a single variable entry.",
                  "type": "boolean"
                },
                "automatic": {
                  "description": "Automatically find non-matching lists to collapse.\nLists on the same path in /devices/device/config\nthat do not compare equal will be collapsed.",
                  "type": "boolean"
                },
                "list-path": {
                  "description": "User provided list of paths to collapse.\n\nOnly the list paths provided by this list will be\ncollapsed. The list will still be omitted from the\ngenerated template if the parent to the list is not included\nin the matching.\n\nPredicates in the XPath will be ignored.",
                  "items": {
                    "type": "string"
                  },
                  "type": "array"
                }
              },
              "type": "object"
            },
            "data": {
              "description": "Configuration data. If loading\nXML the data must be a valid XML document,\neither with a single namespace or wrapped in a\nconfig node with the 'http://tail-f.com/ns/config/1.0'\nnamespace.",
              "type": "string"
            },
            "exclude-service-config": {
              "description": "Exclude configuration that is already under service\nmanagement.",
              "type": "boolean"
            },
            "file": {
              "description": "Name of file with configuration data in the local\nfilesystem.",
              "type": "string"
            },
            "format": {
              "description": "format",
              "enum": [
                "cli-j-cmd",
                "cli-j",
                "cli-c",
                "xml"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "xml",
                "1": "cli-c",
                "2": "cli-j",
                "3": "cli-j-cmd"
              }
            },
            "match-rate": {
              "description": "Include configuration based on this rate of recurrence between\nthe device configurations.\n\nThe action looks at the structural matching between the\ndevice configurations and include configuration based on\nthe match rate. Values are not included in this match.\nLeaf-list entries are seen as a single value.",
              "type": "integer"
            },
            "name": {
              "description": "The name of the new device template.",
              "type": "string"
            },
            "ned-id": {
              "description": "ned-id",
              "type": "string"
            },
            "path": {
              "description": "A list of device configuration paths to create the template\nfrom. The template is only created from the paths that are\ncommon in the nodeset.\n\nAny path pointing to a subtree outside\n/devices/device/config will be ignored.",
              "items": {
                "type": "string"
              },
              "type": "array"
            }
          },
          "required": [
            "path"
          ],
          "type": "object"
        },
        "name": "ncs_devices_create_template"
      },
      {
        "description": "NSO Action: Stop the Java VM (path: /ncs:java-vm/stop)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_java_vm_stop"
      },
      {
        "description": "NSO Action: Stop the Java VM (path: /ncs:java-vm/start)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_java_vm_start"
      },
      {
        "description": "NSO Action: Restart the Java VM (path: /ncs:java-vm/restart)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_java_vm_restart"
      },
      {
        "description": "NSO Action: Restart the Smart Licensing Java VM (path: /ncs:smart-license/smart-agent/restart)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_smart_license_smart_agent_restart"
      },
      {
        "description": "NSO Action: Register device for Smart Licensing (path: /ncs:smart-license/register)",
        "inputSchema": {
          "properties": {
            "force": {
              "description": "Override existing registration information",
              "type": "boolean"
            },
            "idtoken": {
              "description": "User Registration Token to register device",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "ncs_smart_license_register"
      },
      {
        "description": "NSO Action: Deregister device from Smart Licensing (path: /ncs:smart-license/deregister)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_smart_license_deregister"
      },
      {
        "description": "NSO Action: Manually renew Smart Licensing (path: /ncs:smart-license/renew)",
        "inputSchema": {
          "properties": {
            "auth": {
              "description": "Renew authorization of Smart Licenses in use",
              "type": "boolean"
            },
            "id": {
              "description": "Renew registration with Smart Licensing [default]",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_smart_license_renew"
      },
      {
        "description": "NSO Action: Show Smart Licensing state information (path: /ncs:smart-license/show)",
        "inputSchema": {
          "properties": {
            "UDI": {
              "description": "Show the device UDI",
              "type": "boolean"
            },
            "all": {
              "description": "Show all Smart Licensing information",
              "type": "boolean"
            },
            "status": {
              "description": "Show overall Smart Licensing status [default]",
              "type": "boolean"
            },
            "summary": {
              "description": "Show Smart Licensing status summary",
              "type": "boolean"
            },
            "tech-support": {
              "description": "Show Smart Licensing tech support information",
              "type": "boolean"
            },
            "trace": {
              "description": "Show Smart Licensing trace status",
              "type": "boolean"
            },
            "usage": {
              "description": "Show Smart Licensing license usage",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_smart_license_show"
      },
      {
        "description": "NSO Action: Stop the Python VM (path: /ncs:python-vm/stop)",
        "inputSchema": {
          "properties": {
            "name": {
              "description": "Name of the machine to be started. This Name can\neither be a package name or a 'python-vm/vm-name'\nthat can be found in one or several packages.",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "ncs_python_vm_stop"
      },
      {
        "description": "NSO Action: Start the Python VM (path: /ncs:python-vm/start)",
        "inputSchema": {
          "properties": {
            "name": {
              "description": "Name of the machine to be started. This Name can\neither be a package name or a 'python-vm/vm-name'\nthat can be found in one or several packages.",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "ncs_python_vm_start"
      },
      {
        "description": "NSO Action: Redeploy a single package's code (path: /ncs:packages/package/redeploy)",
        "inputSchema": {
          "properties": {
            "__key__package__name": {
              "description": "Key for 'package' list in action path - A unique name, used to identify the package",
              "type": "string",
              "x-list-tag": "package",
              "x-path-key": true
            }
          },
          "required": [
            "__key__package__name"
          ],
          "type": "object"
        },
        "name": "ncs_packages_package_redeploy"
      },
      {
        "description": "NSO Action: Reload all packages (path: /ncs:packages/reload)",
        "inputSchema": {
          "properties": {
            "dry-run": {
              "description": "Reload without applying changes.",
              "type": "boolean"
            },
            "force": {
              "description": "Ignore warnings.",
              "type": "boolean"
            },
            "max-wait-time": {
              "description": "Max time in seconds to wait for commit queue to become empty\n(if 'wait-for-commit-queue-empty' parameter is set) and\ntransactions to close",
              "type": "integer"
            },
            "optimistic": {
              "description": "Use optimistic upgrade",
              "type": "boolean"
            },
            "report": {
              "description": "Generate upgrade report.",
              "enum": [
                "all-schema-paths",
                "no-report"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "no-report",
                "1": "all-schema-paths"
              }
            },
            "timeout-action": {
              "description": "Action taken when max-wait-time is reached",
              "enum": [
                "kill",
                "fail"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "fail",
                "1": "kill"
              }
            },
            "wait-commit-queue-empty": {
              "description": "Enable waiting for commit queue to become empty",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_packages_reload"
      },
      {
        "description": "NSO Action: Add one or more NED packages to a running NCS instance. (path: /ncs:packages/add)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_packages_add"
      },
      {
        "description": "NSO Action: Sync packages in a HA cluster (path: /ncs:packages/ha/sync)",
        "inputSchema": {
          "properties": {
            "and-add": {
              "description": "Add the packages after distribution is\nsuccessfully completed",
              "type": "object"
            },
            "and-reload": {
              "description": "Reload the packages after distribution is\nsuccessfully completed",
              "properties": {
                "dry-run": {
                  "description": "Reload without applying changes.",
                  "type": "boolean"
                },
                "force": {
                  "description": "Ignore warnings.",
                  "type": "boolean"
                },
                "max-wait-time": {
                  "description": "Max time in seconds to wait for commit queue to become empty\n(if 'wait-for-commit-queue-empty' parameter is set) and\ntransactions to close",
                  "type": "integer"
                },
                "optimistic": {
                  "description": "Use optimistic upgrade",
                  "type": "boolean"
                },
                "report": {
                  "description": "Generate upgrade report.",
                  "enum": [
                    "all-schema-paths",
                    "no-report"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "no-report",
                    "1": "all-schema-paths"
                  }
                },
                "timeout-action": {
                  "description": "Action taken when max-wait-time is reached",
                  "enum": [
                    "kill",
                    "fail"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "fail",
                    "1": "kill"
                  }
                },
                "wait-commit-queue-empty": {
                  "description": "Enable waiting for commit queue to become empty",
                  "type": "boolean"
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "ncs_packages_ha_sync"
      },
      {
        "description": "NSO Action: Clear the list of automatically registered read-write\nconflicts. (path: /ncs:services/scheduling/clear)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_services_scheduling_clear"
      },
      {
        "description": "NSO Action: Check if device configuration is according to the services (path: /ncs:services/check-sync)",
        "inputSchema": {
          "properties": {
            "deep": {
              "description": "deep",
              "type": "boolean"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "outformat": {
              "description": "outformat",
              "enum": [
                "cli-c",
                "boolean",
                "native",
                "xml",
                "cli"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "cli",
                "1": "xml",
                "2": "native",
                "3": "boolean",
                "4": "cli-c"
              }
            },
            "service-id": {
              "description": "The service instance.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "service-type": {
              "description": "The type of service.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "shallow": {
              "description": "shallow",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Return list only contains negatives",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "Force handling LSA nodes as such.",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_services_check_sync"
      },
      {
        "description": "NSO Action: Run/Dry-run the service logic again (path: /ncs:services/re-deploy)",
        "inputSchema": {
          "properties": {
            "comment": {
              "description": "A comment attached to any rollback file created as a result\nof the transaction. If supported, the comment will also\nbe propagated down to the device.",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "The error option to use. Depending on the selected error option\nNCS will store the reverse of the original transaction\nto be able to undo the transaction changes and get back to the\nprevious state. This data is stored in the\n/devices/commit-queue/completed tree from where it can\nbe viewed and invoked with the rollback action. When invoked\nthe data will be removed.",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "Unique id identifying a queue item. If locked, this\nitem will be unlocked in the commit phase.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "If this container is created, the commit will make a\nconfirm-network-state sync check on the participating devices.",
              "properties": {
                "compare": {
                  "description": "The scope of the confirm-network-state check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "Re-evaluate all saved extra-create-ops operations\nagainst the current set of out-of-band policies.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "deep": {
              "description": "deep",
              "type": "boolean"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                },
                "with-service-meta-data": {
                  "description": "Include changes to service meta-data.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "label": {
              "description": "User defined label. The label is present in\nrollback files, notifications and events referencing\nthe transaction.",
              "type": "string"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "no-networking": {
              "description": "Do not send any data to the devices. Even if the transaction\nmanipulates data below /devices/device/config, nothing will\nbe sent to the managed devices. This is a way to manipulate\nCDB in NCS without generating any southbound traffic.",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that a device's\nconfiguration is out of sync. The device's sync state is assumed\nto be unknown after such commit and the stored transaction id\nvalue is cleared",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "This flag means that NCS will check that the modified data and\noptionally the data read when computing the device modifications\nhave not changed on the device compared to NCS's view of the data.\nValidating the data read when computing the device modifications\nis important because the read data might be a prerequisite to\nbeing able to write the data successfully; there might exist\nconstraints on the modified data (e.g., a 'must' statement) that\nare fulfilled in NCS but not on the device.\n\nThis is a fine-grained sync check; NCS verifies that NCS\nand the device are in sync regarding the data that will be\nmodified and optionally the data read when computing the device\nmodifications. If they are not in sync, the transaction is\naborted.",
              "properties": {
                "compare": {
                  "description": "The scope of the no-overwrite check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "This flag means that NCS will not run its data model revision\nalgorithm, which requires all participating managed devices\nto have all parts of the data models for all data contained\nin this transaction. Thus, this flag forces NCS to never\nsilently drop any data set operations towards a device.",
              "type": "boolean"
            },
            "reconcile": {
              "description": "Reconcile the service data. All data which existed before\nthe service was created will now be owned by the service.\nThe reference count will indicate how many services control\nthe data. When the service is removed that data will also be\nremoved. In technical terms the reference count will be\ndecreased by one for everything which existed prior to the\nservice.\n\nIf manually configured data exists below in the configuration\ntree that data is kept unless the option\n'discard-non-service-config' is used.\n\n'keep-non-service-config' will keep manually configured data by\nincreasing the refcounts and thereby store it as if it was\nexisting already before the service was created.\n\n'attach-non-service-config' will take data that otherwise\nwill exist also after the last service is deleted,\ndecrease the refcounts and instead store it as\nout-of-band data that is managed by the service.\nThis is similar to what a commit confirm-network-state would\ndo for detected out-of-band data.\n\n'detach-non-service-config' will take all out-of-band data that\nis managed by a service and instead increase the refcounts so\nthe data will exist also after the service is deleted. Similar\nto what a reconcile 'keep-non-service-config' would do.",
              "properties": {
                "attach-non-service-config": {
                  "description": "attach-non-service-config",
                  "type": "boolean"
                },
                "detach-non-service-config": {
                  "description": "detach-non-service-config",
                  "type": "boolean"
                },
                "discard-non-service-config": {
                  "description": "discard-non-service-config",
                  "type": "boolean"
                },
                "exclude": {
                  "description": "List of paths to be excluded in the reconciliation.",
                  "items": {
                    "type": "string"
                  },
                  "type": "array"
                },
                "include": {
                  "description": "List of paths to be included in the reconciliation.",
                  "items": {
                    "type": "string"
                  },
                  "type": "array"
                },
                "keep-non-service-config": {
                  "description": "keep-non-service-config",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "select-services": {
              "description": "Re-deploy services selected by an XPath expression.",
              "type": "string"
            },
            "service-id": {
              "description": "Re-deploy specific service instances.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "service-type": {
              "description": "Re-deploy all services of a certain type.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "shallow": {
              "description": "shallow",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Suppress services with empty diffs",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "Force handling of the LSA nodes as such. This flag tells\nNCS to propagate applicable commit flags and actions\nto the LSA nodes without applying them on the upper\nNCS node itself. The commit flags affected are\n'dry-run', 'no-networking', 'no-out-of-sync-check',\n'no-overwrite', 'no-revision-drop' and 'confirm-network-state'.",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_services_re_deploy"
      },
      {
        "description": "NSO Action: Undo the effects of the service (path: /ncs:services/un-deploy)",
        "inputSchema": {
          "properties": {
            "comment": {
              "description": "A comment attached to any rollback file created as a result\nof the transaction. If supported, the comment will also\nbe propagated down to the device.",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "The error option to use. Depending on the selected error option\nNCS will store the reverse of the original transaction\nto be able to undo the transaction changes and get back to the\nprevious state. This data is stored in the\n/devices/commit-queue/completed tree from where it can\nbe viewed and invoked with the rollback action. When invoked\nthe data will be removed.",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "Unique id identifying a queue item. If locked, this\nitem will be unlocked in the commit phase.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "If this container is created, the commit will make a\nconfirm-network-state sync check on the participating devices.",
              "properties": {
                "compare": {
                  "description": "The scope of the confirm-network-state check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "Re-evaluate all saved extra-create-ops operations\nagainst the current set of out-of-band policies.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                },
                "with-service-meta-data": {
                  "description": "Include changes to service meta-data.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "ignore-refcount": {
              "description": "Unconditionally delete the device data created by the\nservice, regardless of the refcount.",
              "type": "boolean"
            },
            "label": {
              "description": "User defined label. The label is present in\nrollback files, notifications and events referencing\nthe transaction.",
              "type": "string"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "no-networking": {
              "description": "Do not send any data to the devices. Even if the transaction\nmanipulates data below /devices/device/config, nothing will\nbe sent to the managed devices. This is a way to manipulate\nCDB in NCS without generating any southbound traffic.",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that a device's\nconfiguration is out of sync. The device's sync state is assumed\nto be unknown after such commit and the stored transaction id\nvalue is cleared",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "This flag means that NCS will check that the modified data and\noptionally the data read when computing the device modifications\nhave not changed on the device compared to NCS's view of the data.\nValidating the data read when computing the device modifications\nis important because the read data might be a prerequisite to\nbeing able to write the data successfully; there might exist\nconstraints on the modified data (e.g., a 'must' statement) that\nare fulfilled in NCS but not on the device.\n\nThis is a fine-grained sync check; NCS verifies that NCS\nand the device are in sync regarding the data that will be\nmodified and optionally the data read when computing the device\nmodifications. If they are not in sync, the transaction is\naborted.",
              "properties": {
                "compare": {
                  "description": "The scope of the no-overwrite check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "This flag means that NCS will not run its data model revision\nalgorithm, which requires all participating managed devices\nto have all parts of the data models for all data contained\nin this transaction. Thus, this flag forces NCS to never\nsilently drop any data set operations towards a device.",
              "type": "boolean"
            },
            "select-services": {
              "description": "Un-deploy services selected by an XPath expression.",
              "type": "string"
            },
            "service-id": {
              "description": "Un-deploy specific service instances.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "service-type": {
              "description": "Un-deploy all services of a certain type.",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "suppress-positive-result": {
              "description": "Suppress services with empty diffs",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "Force handling of the LSA nodes as such. This flag tells\nNCS to propagate applicable commit flags and actions\nto the LSA nodes without applying them on the upper\nNCS node itself. The commit flags affected are\n'dry-run', 'no-networking', 'no-out-of-sync-check',\n'no-overwrite', 'no-revision-drop' and 'confirm-network-state'.",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_services_un_deploy"
      },
      {
        "description": "NSO Action: Create a service template from existing configuration. (path: /ncs:services/create-template)",
        "inputSchema": {
          "properties": {
            "augment": {
              "description": "Includes an augment statement in the generated YANG module.\n\nThe XPath needs to be an absolute location path.\nPredicates in the XPath will be ignored.",
              "type": "string"
            },
            "collapse-list-keys": {
              "description": "Collapse list keys into a single entry. The key\nwill be made into a XPath location path to\nthe service input parameter.",
              "properties": {
                "all": {
                  "description": "All list keys will be made into a single variable entry.",
                  "type": "boolean"
                },
                "automatic": {
                  "description": "Automatically find non-matching lists to collapse.\nLists on the same path in /devices/device/config\nthat do not compare equal will be collapsed.",
                  "type": "boolean"
                },
                "list-path": {
                  "description": "User provided list of paths to collapse.\n\nOnly the list paths provided by this list will be\ncollapsed. The list will still be omitted from the\ngenerated template if the parent to the list is not\nincluded in the matching.\n\nPredicates in the XPath will be ignored.",
                  "items": {
                    "type": "string"
                  },
                  "type": "array"
                }
              },
              "type": "object"
            },
            "data": {
              "description": "Configuration data. If loading\nXML the data must be a valid XML document,\neither with a single namespace or wrapped in a\nconfig node with the http://tail-f.com/ns/config/1.0\nnamespace.",
              "type": "string"
            },
            "device-template": {
              "description": "The device template to create a service template from.",
              "properties": {
                "name": {
                  "description": "name",
                  "type": "string"
                },
                "ned-id": {
                  "description": "ned-id",
                  "type": "string"
                }
              },
              "type": "object"
            },
            "exclude-service-config": {
              "description": "Exclude configuration that is already under service\nmanagement.",
              "type": "boolean"
            },
            "file": {
              "description": "Name of file with configuration data in the local\nfilesystem.",
              "type": "string"
            },
            "format": {
              "description": "format",
              "enum": [
                "cli-j-cmd",
                "cli-j",
                "cli-c",
                "xml"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "xml",
                "1": "cli-c",
                "2": "cli-j",
                "3": "cli-j-cmd"
              }
            },
            "import-user-modules": {
              "description": "Import user modules and their defined types in the\ngenerated YANG module.",
              "type": "boolean"
            },
            "include-doc": {
              "description": "Include descriptions derived from the used schema\nin the generated YANG module.",
              "type": "boolean"
            },
            "make-package": {
              "description": "Create a service package including the generated template and YANG\nmodule. The package is created in the specified parent directory,\nbut does not build it. The package needs to be built separately\nby running 'make' in its src/ subdirectory. The user has the\nfreedom of making modifications to the generated files.",
              "properties": {
                "in-directory": {
                  "description": "Specifies a directory where the generated service package is\nstored. The user must have write access to the specified\ndirectory.",
                  "type": "string"
                },
                "overwrite": {
                  "description": "Overwrite any existing file.\n\nIf the file with the generated name already exists in the\nspecified directory, then replace it with the new one.\nIf the file exists in the directory and this option is not\nspecified, then the action will fail.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "match-rate": {
              "description": "Include configuration based on this rate of recurrence\nbetween the device configurations.\n\nThe action looks at the structural matching between the\ndevice configurations and include configuration based on\nthe match rate. Values are not included in this match.\nLeaf-list entries are seen as a single value.",
              "type": "integer"
            },
            "name": {
              "description": "The name of the new service.",
              "type": "string"
            },
            "ned-id": {
              "description": "ned-id",
              "type": "string"
            },
            "path": {
              "description": "A list of device configuration paths to create the template\nfrom. The template is only created from the paths that are\ncommon in the nodeset.\n\nAny path pointing to a subtree outside\n/devices/device/config will be ignored.",
              "items": {
                "type": "string"
              },
              "type": "array"
            }
          },
          "required": [
            "path"
          ],
          "type": "object"
        },
        "name": "ncs_services_create_template"
      },
      {
        "description": "NSO Action: Run this compliance report (path: /ncs:compliance/reports/report/run)",
        "inputSchema": {
          "properties": {
            "__key__report__name": {
              "description": "Key for 'report' list in action path - Compliance report name",
              "type": "string",
              "x-list-tag": "report",
              "x-path-key": true
            },
            "diff-outformat": {
              "description": "diff-outformat",
              "enum": [
                "xml",
                "cli-c",
                "cli"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "cli",
                "1": "cli-c",
                "2": "xml"
              }
            },
            "from": {
              "description": "Historical data from this time",
              "type": "string"
            },
            "outformat": {
              "description": "The format of the report output file.",
              "enum": [
                "sqlite",
                "html",
                "xml",
                "text"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "text",
                "1": "xml",
                "2": "html",
                "3": "sqlite"
              }
            },
            "title": {
              "description": "Report name + title in report header",
              "type": "string"
            },
            "to": {
              "description": "Historical data to this time",
              "type": "string"
            }
          },
          "required": [
            "__key__report__name"
          ],
          "type": "object"
        },
        "name": "ncs_compliance_reports_report_run"
      },
      {
        "description": "NSO Action: Remove this report result (path: /ncs:compliance/report-results/report/remove)",
        "inputSchema": {
          "properties": {
            "__key__report__time": {
              "description": "Key for 'report' list in action path - The date and time when this report output file was produced",
              "type": "string",
              "x-list-tag": "report",
              "x-path-key": true
            }
          },
          "required": [
            "__key__report__time"
          ],
          "type": "object"
        },
        "name": "ncs_compliance_report_results_report_remove"
      },
      {
        "description": "NSO Action: Export an existing report to other formats (path: /ncs:compliance/report-results/report/export)",
        "inputSchema": {
          "properties": {
            "__key__report__time": {
              "description": "Key for 'report' list in action path - The date and time when this report output file was produced",
              "type": "string",
              "x-list-tag": "report",
              "x-path-key": true
            },
            "outformat": {
              "description": "The format of the report output file.",
              "enum": [
                "xml",
                "text"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "text",
                "1": "xml"
              }
            }
          },
          "required": [
            "__key__report__time"
          ],
          "type": "object"
        },
        "name": "ncs_compliance_report_results_report_export"
      },
      {
        "description": "NSO Action: Re-run non-compliant items (path: /ncs:compliance/report-results/report/re-run)",
        "inputSchema": {
          "properties": {
            "__key__report__time": {
              "description": "Key for 'report' list in action path - The date and time when this report output file was produced",
              "type": "string",
              "x-list-tag": "report",
              "x-path-key": true
            },
            "diff-outformat": {
              "description": "diff-outformat",
              "enum": [
                "xml",
                "cli-c",
                "cli"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "cli",
                "1": "cli-c",
                "2": "xml"
              }
            },
            "outformat": {
              "description": "The format of the report output file.",
              "enum": [
                "sqlite",
                "html",
                "xml",
                "text"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "text",
                "1": "xml",
                "2": "html",
                "3": "sqlite"
              }
            },
            "title": {
              "description": "Title for the new re-run report",
              "type": "string"
            }
          },
          "required": [
            "__key__report__time"
          ],
          "type": "object"
        },
        "name": "ncs_compliance_report_results_report_re_run"
      },
      {
        "description": "NSO Action: Check the configuration of some device(s) (path: /ncs:compliance/template/check)",
        "inputSchema": {
          "properties": {
            "__key__template__name": {
              "description": "Key for 'template' list in action path - The name of a specific template check.",
              "type": "string",
              "x-list-tag": "template",
              "x-path-key": true
            },
            "all-devices": {
              "description": "Report on all devices",
              "type": "boolean"
            },
            "device": {
              "description": "Report on specific devices",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Report on specific device groups",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "diff-outformat": {
              "description": "diff-outformat",
              "enum": [
                "xml",
                "cli-c",
                "cli"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "cli",
                "1": "cli-c",
                "2": "xml"
              }
            },
            "select-devices": {
              "description": "Report on devices selected by an XPath expression",
              "type": "string"
            },
            "strict": {
              "description": "Use strict mode when verifying device configuration",
              "type": "boolean"
            },
            "variable": {
              "description": "variable",
              "properties": {
                "name": {
                  "description": "name",
                  "type": "string"
                },
                "value": {
                  "description": "value",
                  "type": "string"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__template__name"
          ],
          "type": "object"
        },
        "name": "ncs_compliance_template_check"
      },
      {
        "description": "NSO Action: Check the configuration of some device(s) (path: /ncs:compliance/xml-templates/check)",
        "inputSchema": {
          "properties": {
            "all-devices": {
              "description": "Report on all devices",
              "type": "boolean"
            },
            "device": {
              "description": "Report on specific devices",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "device-group": {
              "description": "Report on specific device groups",
              "items": {
                "type": "string"
              },
              "type": "array"
            },
            "diff-outformat": {
              "description": "diff-outformat",
              "enum": [
                "xml",
                "cli-c",
                "cli"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "cli",
                "1": "cli-c",
                "2": "xml"
              }
            },
            "select-devices": {
              "description": "Report on devices selected by an XPath expression",
              "type": "string"
            },
            "strict": {
              "description": "Use strict mode when verifying device configuration",
              "type": "boolean"
            },
            "template-name": {
              "description": "The XML template to check for compliance.",
              "type": "string"
            },
            "variable": {
              "description": "variable",
              "properties": {
                "name": {
                  "description": "name",
                  "type": "string"
                },
                "value": {
                  "description": "value",
                  "type": "string"
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        },
        "name": "ncs_compliance_xml_templates_check"
      },
      {
        "description": "NSO Action: Reload all XML compliance templates (path: /ncs:compliance/xml-templates/reload)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_compliance_xml_templates_reload"
      },
      {
        "description": "NSO Action: Create a compliance template from a device template or existing\nconfiguration.\n\nBe aware that the values of the nodes in the device\ntemplate are not changed and if they include valid regular expressions\nthey will be treated as such when checking the compliance template\ngenerated from the device template. (path: /ncs:compliance/create-template)",
        "inputSchema": {
          "properties": {
            "collapse-list-keys": {
              "description": "Collapse list keys into a single entry. The key\nwill be made into a regex match-all expression.",
              "properties": {
                "all": {
                  "description": "All list keys will be made into a single entry.",
                  "type": "boolean"
                },
                "automatic": {
                  "description": "Automatically find non-matching lists to collapse.\nLists on the same path in /devices/device/config\nthat do not compare equal will be collapsed.",
                  "type": "boolean"
                },
                "list-path": {
                  "description": "User provided list of paths to collapse.\n\nOnly the list paths provided by this list will be\ncollapsed. The list will still be omitted from the\ngenerated template if the parent to the list is not\nincluded in the matching.\n\nPredicates in the XPath will be ignored.",
                  "items": {
                    "type": "string"
                  },
                  "type": "array"
                }
              },
              "type": "object"
            },
            "data": {
              "description": "Configuration data. If loading\nXML the data must be a valid XML document,\neither with a single namespace or wrapped in a\nconfig node with the http://tail-f.com/ns/config/1.0\nnamespace.",
              "type": "string"
            },
            "device-template": {
              "description": "The device template to create a compliance template from.",
              "type": "string"
            },
            "exclude-service-config": {
              "description": "Exclude configuration that is already under service\nmanagement.",
              "type": "boolean"
            },
            "file": {
              "description": "Name of file with configuration data in the local\nfilesystem.",
              "type": "string"
            },
            "format": {
              "description": "format",
              "enum": [
                "cli-j-cmd",
                "cli-j",
                "cli-c",
                "xml"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "xml",
                "1": "cli-c",
                "2": "cli-j",
                "3": "cli-j-cmd"
              }
            },
            "match-rate": {
              "description": "Include configuration based on this rate of recurrence\nbetween the device configurations.\n\nThe action looks at the structural matching between the\ndevice configurations and include configuration based on\nthe match rate. Values are not included in this match.\nLeaf-list entries are seen as a single value.",
              "type": "integer"
            },
            "name": {
              "description": "The name of the new compliance template. Leave empty to use the\nsame name as the device template.",
              "type": "string"
            },
            "ned-id": {
              "description": "ned-id",
              "type": "string"
            },
            "path": {
              "description": "A list of device configuration paths to create the template\nfrom. The template is only created from the paths that are\ncommon in the nodeset.\n\nAny path pointing to a subtree outside\n/devices/device/config will be ignored.",
              "items": {
                "type": "string"
              },
              "type": "array"
            }
          },
          "required": [
            "path"
          ],
          "type": "object"
        },
        "name": "ncs_compliance_create_template"
      },
      {
        "description": "NSO Action: List local packages (path: /ncs:software/packages/list)",
        "inputSchema": {
          "properties": {
            "all-versions": {
              "description": "Consider as installable regardless of system version",
              "type": "boolean"
            },
            "installable": {
              "description": "List only installable packages",
              "type": "boolean"
            },
            "installed": {
              "description": "List only installed packages",
              "type": "boolean"
            },
            "loaded": {
              "description": "List only loaded packages",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_software_packages_list"
      },
      {
        "description": "NSO Action: Upload a package via NETCONF or RESTCONF (path: /ncs:software/packages/upload)",
        "inputSchema": {
          "properties": {
            "package": {
              "description": "Package name",
              "type": "string"
            },
            "package-data": {
              "description": "Package data",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "ncs_software_packages_upload"
      },
      {
        "description": "NSO Action: Fetch a package from the file system (path: /ncs:software/packages/fetch)",
        "inputSchema": {
          "properties": {
            "package-from-file": {
              "description": "File name",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "ncs_software_packages_fetch"
      },
      {
        "description": "NSO Action: Install a package (path: /ncs:software/packages/install)",
        "inputSchema": {
          "properties": {
            "allow-version-mismatch": {
              "description": "Allow install regardless of system version",
              "type": "boolean"
            },
            "expanded": {
              "description": "Expand the package tar archive to a directory tree",
              "type": "boolean"
            },
            "package": {
              "description": "Package name",
              "type": "string"
            },
            "replace-existing": {
              "description": "Replace any previously installed version(s)",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_software_packages_install"
      },
      {
        "description": "NSO Action: Deinstall a package (path: /ncs:software/packages/deinstall)",
        "inputSchema": {
          "properties": {
            "package": {
              "description": "Package name",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "ncs_software_packages_deinstall"
      },
      {
        "description": "NSO Action: Reshedule side-effect with status failed or canceled. (path: /ncs:side-effect-queue/side-effect/reschedule)",
        "inputSchema": {
          "properties": {
            "__key__side-effect__id": {
              "description": "Key for 'side-effect' list in action path - Unique identification of the side-effect action",
              "type": "string",
              "x-list-tag": "side-effect",
              "x-path-key": true
            }
          },
          "required": [
            "__key__side-effect__id"
          ],
          "type": "object"
        },
        "name": "ncs_side_effect_queue_side_effect_reschedule"
      },
      {
        "description": "NSO Action: Invoke queued side-effects asynchronously (path: /ncs:side-effect-queue/invoke)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_side_effect_queue_invoke"
      },
      {
        "description": "NSO Action: Purge all failed side effects (path: /ncs:side-effect-queue/purge)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_side_effect_queue_purge"
      },
      {
        "description": "NSO Action: Get the data this service created (path: /ncs:zombies/service/plan/component/state/get-modifications)",
        "inputSchema": {
          "properties": {
            "__key__component__name": {
              "description": "Key for 'component' list in action path - Key 'name' for list 'component'",
              "type": "string",
              "x-list-tag": "component",
              "x-path-key": true
            },
            "__key__component__type": {
              "description": "Key for 'component' list in action path - The plan component type is defined by an YANG identity.\nIt is used to identify the characteristics of a certain component.\nTherefore, if two components in the same service are of the same\ntype they should be identical with respect to number, type and order\nof their contained states.",
              "type": "string",
              "x-list-tag": "component",
              "x-path-key": true
            },
            "__key__service__service-path": {
              "description": "Key for 'service' list in action path - The path to where the service resided that has been deleted\nand become a zombie.",
              "type": "string",
              "x-list-tag": "service",
              "x-path-key": true
            },
            "__key__state__name": {
              "description": "Key for 'state' list in action path - Key 'name' for list 'state'",
              "type": "string",
              "x-list-tag": "state",
              "x-path-key": true
            },
            "deep": {
              "description": "deep",
              "type": "boolean"
            },
            "forward": {
              "description": "Show the service modifications.",
              "properties": {
                "only-out-of-band": {
                  "description": "Only show the accepted out-of-band changes managed by\nthe services.",
                  "type": "boolean"
                },
                "only-service": {
                  "description": "Show the service modifications.",
                  "type": "boolean"
                },
                "with-out-of-band": {
                  "description": "Show the service modifications combined with the\naccepted out-of-band changes managed by the service.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "outformat": {
              "description": "outformat",
              "enum": [
                "cli-c",
                "xml",
                "cli"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "cli",
                "1": "xml",
                "4": "cli-c"
              }
            },
            "reverse": {
              "description": "Show the modifications needed to 'reverse' the effect of\nthe service.",
              "type": "boolean"
            },
            "shallow": {
              "description": "shallow",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "Force handling LSA nodes as such.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__service__service-path",
            "__key__component__type",
            "__key__component__name",
            "__key__state__name"
          ],
          "type": "object"
        },
        "name": "ncs_zombies_service_plan_component_state_get_modifications"
      },
      {
        "description": "NSO Action: Force a component to back-track (path: /ncs:zombies/service/plan/component/force-back-track)",
        "inputSchema": {
          "properties": {
            "__key__component__name": {
              "description": "Key for 'component' list in action path - Key 'name' for list 'component'",
              "type": "string",
              "x-list-tag": "component",
              "x-path-key": true
            },
            "__key__component__type": {
              "description": "Key for 'component' list in action path - The plan component type is defined by an YANG identity.\nIt is used to identify the characteristics of a certain component.\nTherefore, if two components in the same service are of the same\ntype they should be identical with respect to number, type and order\nof their contained states.",
              "type": "string",
              "x-list-tag": "component",
              "x-path-key": true
            },
            "__key__service__service-path": {
              "description": "Key for 'service' list in action path - The path to where the service resided that has been deleted\nand become a zombie.",
              "type": "string",
              "x-list-tag": "service",
              "x-path-key": true
            },
            "back-tracking-goal": {
              "description": "Target state for back-track.",
              "type": "string"
            },
            "comment": {
              "description": "A comment attached to any rollback file created as a result\nof the transaction. If supported, the comment will also\nbe propagated down to the device.",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "The error option to use. Depending on the selected error option\nNCS will store the reverse of the original transaction\nto be able to undo the transaction changes and get back to the\nprevious state. This data is stored in the\n/devices/commit-queue/completed tree from where it can\nbe viewed and invoked with the rollback action. When invoked\nthe data will be removed.",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "Unique id identifying a queue item. If locked, this\nitem will be unlocked in the commit phase.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "If this container is created, the commit will make a\nconfirm-network-state sync check on the participating devices.",
              "properties": {
                "compare": {
                  "description": "The scope of the confirm-network-state check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "Re-evaluate all saved extra-create-ops operations\nagainst the current set of out-of-band policies.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "label": {
              "description": "User defined label. The label is present in\nrollback files, notifications and events referencing\nthe transaction.",
              "type": "string"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "no-networking": {
              "description": "Do not send any data to the devices. Even if the transaction\nmanipulates data below /devices/device/config, nothing will\nbe sent to the managed devices. This is a way to manipulate\nCDB in NCS without generating any southbound traffic.",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that a device's\nconfiguration is out of sync. The device's sync state is assumed\nto be unknown after such commit and the stored transaction id\nvalue is cleared",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "This flag means that NCS will check that the modified data and\noptionally the data read when computing the device modifications\nhave not changed on the device compared to NCS's view of the data.\nValidating the data read when computing the device modifications\nis important because the read data might be a prerequisite to\nbeing able to write the data successfully; there might exist\nconstraints on the modified data (e.g., a 'must' statement) that\nare fulfilled in NCS but not on the device.\n\nThis is a fine-grained sync check; NCS verifies that NCS\nand the device are in sync regarding the data that will be\nmodified and optionally the data read when computing the device\nmodifications. If they are not in sync, the transaction is\naborted.",
              "properties": {
                "compare": {
                  "description": "The scope of the no-overwrite check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "This flag means that NCS will not run its data model revision\nalgorithm, which requires all participating managed devices\nto have all parts of the data models for all data contained\nin this transaction. Thus, this flag forces NCS to never\nsilently drop any data set operations towards a device.",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "Force handling of the LSA nodes as such. This flag tells\nNCS to propagate applicable commit flags and actions\nto the LSA nodes without applying them on the upper\nNCS node itself. The commit flags affected are\n'dry-run', 'no-networking', 'no-out-of-sync-check',\n'no-overwrite', 'no-revision-drop' and 'confirm-network-state'.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__service__service-path",
            "__key__component__type",
            "__key__component__name"
          ],
          "type": "object"
        },
        "name": "ncs_zombies_service_plan_component_force_back_track"
      },
      {
        "description": "NSO Action: Remove log entries (path: /ncs:zombies/service/log/purge)",
        "inputSchema": {
          "properties": {
            "__key__service__service-path": {
              "description": "Key for 'service' list in action path - The path to where the service resided that has been deleted\nand become a zombie.",
              "type": "string",
              "x-list-tag": "service",
              "x-path-key": true
            },
            "level": {
              "description": "level",
              "enum": [
                "error",
                "warn",
                "info",
                "debug",
                "trace",
                "all"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "1": "all",
                "2": "trace",
                "3": "debug",
                "4": "info",
                "5": "warn",
                "6": "error"
              }
            },
            "older-than": {
              "description": "Matches the 'when' leaf in the log entry.",
              "properties": {
                "days": {
                  "description": "days",
                  "type": "integer"
                },
                "hours": {
                  "description": "hours",
                  "type": "integer"
                },
                "minutes": {
                  "description": "minutes",
                  "type": "integer"
                },
                "seconds": {
                  "description": "seconds",
                  "type": "integer"
                },
                "weeks": {
                  "description": "weeks",
                  "type": "integer"
                }
              },
              "type": "object"
            },
            "type": {
              "description": "type",
              "type": "string"
            }
          },
          "required": [
            "__key__service__service-path"
          ],
          "type": "object"
        },
        "name": "ncs_zombies_service_log_purge"
      },
      {
        "description": "NSO Action: revive the zombie and re-deploy it. (path: /ncs:zombies/service/re-deploy)",
        "inputSchema": {
          "properties": {
            "__key__service__service-path": {
              "description": "Key for 'service' list in action path - The path to where the service resided that has been deleted\nand become a zombie.",
              "type": "string",
              "x-list-tag": "service",
              "x-path-key": true
            },
            "comment": {
              "description": "A comment attached to any rollback file created as a result\nof the transaction. If supported, the comment will also\nbe propagated down to the device.",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "Commit the transaction data asynchronously to the commit queue.\nThis flag is useful when some device is non-operational or\nhas data waiting in the commit queue.\n\nThe operation returns successfully if the transaction data has\nbeen successfully placed in the queue. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'async' in the result.",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "Sets the atomic behaviour of the resulting queue item.\nIf this is set to false, the devices contained in the\nresulting queue item can start executing if the same devices\nin other non-atomic queue items ahead of it in the queue are\ncompleted. If set to true, the atomic integrity of the\nqueue item is preserved.",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "The resulting queue item will block subsequent queue items,\nwhich use any of the devices in this queue item, from\nbeing queued.",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "This flag means that if\n/devices/commit-queue/enabled-by-default is 'true' the\ndata in this transaction will bypass the commit queue.\nThe data will be written directly to the devices.",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "The error option to use. Depending on the selected error option\nNCS will store the reverse of the original transaction\nto be able to undo the transaction changes and get back to the\nprevious state. This data is stored in the\n/devices/commit-queue/completed tree from where it can\nbe viewed and invoked with the rollback action. When invoked\nthe data will be removed.",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "Place a lock on the resulting queue item. The queue\nitem will not be processed until it has been unlocked,\nsee the actions 'unlock' and 'lock' in\n/devices/commit-queue/queue-item'.\n\nNo following queue items, using the same devices, will be\nallowed to execute as long as the lock is in place.",
                  "type": "boolean"
                },
                "sync": {
                  "description": "Commit the transaction data synchronously to the commit queue.\n\nThe operation does not return until the transaction data has\nbeen sent to all devices, or a timeout occurs. The leaf\n'commit-queue/id' is set as the queue identifier and the\nleaf 'commit-queue/status' is set to 'completed', 'failed',\n'deleted' or 'timeout' dependent of the outcome.\n\nIf no device is involved in the transaction, the operation\nreturns directly.",
                  "properties": {
                    "infinity": {
                      "description": "Wait infinitely for the transaction to be committed.",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "Specifies a maximum number of seconds to wait for the\ntransaction to be committed. If the timer expires, the\ntransaction is kept in the commit-queue, and the operation\nreturns successfully. The leaf 'commit-queue/status'\nis set to 'timeout', and the leaf 'commit-queue/id' is\nset to the queue identifier in the result.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "Unique id identifying a queue item. If locked, this\nitem will be unlocked in the commit phase.",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "If this container is created, the commit will make a\nconfirm-network-state sync check on the participating devices.",
              "properties": {
                "compare": {
                  "description": "The scope of the confirm-network-state check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "Re-deploy all services affected by the discovered out-of-band\ndata.",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "Re-evaluate all saved extra-create-ops operations\nagainst the current set of out-of-band policies.",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "label": {
              "description": "User defined label. The label is present in\nrollback files, notifications and events referencing\nthe transaction.",
              "type": "string"
            },
            "no-lsa": {
              "description": "Do not handle any of the LSA nodes as such. These nodes\nwill be handled as any other device.",
              "type": "boolean"
            },
            "no-networking": {
              "description": "Do not send any data to the devices. Even if the transaction\nmanipulates data below /devices/device/config, nothing will\nbe sent to the managed devices. This is a way to manipulate\nCDB in NCS without generating any southbound traffic.",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "Continue with the transaction even if NCS detects that a device's\nconfiguration is out of sync. The device's sync state is assumed\nto be unknown after such commit and the stored transaction id\nvalue is cleared",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "This flag means that NCS will check that the modified data and\noptionally the data read when computing the device modifications\nhave not changed on the device compared to NCS's view of the data.\nValidating the data read when computing the device modifications\nis important because the read data might be a prerequisite to\nbeing able to write the data successfully; there might exist\nconstraints on the modified data (e.g., a 'must' statement) that\nare fulfilled in NCS but not on the device.\n\nThis is a fine-grained sync check; NCS verifies that NCS\nand the device are in sync regarding the data that will be\nmodified and optionally the data read when computing the device\nmodifications. If they are not in sync, the transaction is\naborted.",
              "properties": {
                "compare": {
                  "description": "The scope of the no-overwrite check.",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "This flag means that NCS will not run its data model revision\nalgorithm, which requires all participating managed devices\nto have all parts of the data models for all data contained\nin this transaction. Thus, this flag forces NCS to never\nsilently drop any data set operations towards a device.",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "Force handling of the LSA nodes as such. This flag tells\nNCS to propagate applicable commit flags and actions\nto the LSA nodes without applying them on the upper\nNCS node itself. The commit flags affected are\n'dry-run', 'no-networking', 'no-out-of-sync-check',\n'no-overwrite', 'no-revision-drop' and 'confirm-network-state'.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__service__service-path"
          ],
          "type": "object"
        },
        "name": "ncs_zombies_service_re_deploy"
      },
      {
        "description": "NSO Action: revive the zombie and reactive re-deploy it. (path: /ncs:zombies/service/reactive-re-deploy)",
        "inputSchema": {
          "properties": {
            "__key__service__service-path": {
              "description": "Key for 'service' list in action path - The path to where the service resided that has been deleted\nand become a zombie.",
              "type": "string",
              "x-list-tag": "service",
              "x-path-key": true
            },
            "sync": {
              "description": "By default the action is asynchronous, i.e. it does not wait for\nthe service to be re-deployed. Use this leaf to get synchronous\nbehaviour and block until the service re-deploy transaction is\ncommitted. It also means that the action will possibly return\na commit result, such as commit queue id if any, or an\nerror if the transaction failed.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__service__service-path"
          ],
          "type": "object"
        },
        "name": "ncs_zombies_service_reactive_re_deploy"
      },
      {
        "description": "NSO Action: Load the zombie back as service in current state. (path: /ncs:zombies/service/resurrect)",
        "inputSchema": {
          "properties": {
            "__key__service__service-path": {
              "description": "Key for 'service' list in action path - The path to where the service resided that has been deleted\nand become a zombie.",
              "type": "string",
              "x-list-tag": "service",
              "x-path-key": true
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__service__service-path"
          ],
          "type": "object"
        },
        "name": "ncs_zombies_service_resurrect"
      },
      {
        "description": "NSO Action: Order the local node to assume ha role primary (path: /ncs:high-availability/be-primary)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_high_availability_be_primary"
      },
      {
        "description": "NSO Action: Order the local node to assume ha role none (path: /ncs:high-availability/be-none)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_high_availability_be_none"
      },
      {
        "description": "NSO Action: Order the local node to connect as secondary to the provided\nha node (path: /ncs:high-availability/be-secondary-to)",
        "inputSchema": {
          "properties": {
            "node": {
              "description": "node",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "ncs_high_availability_be_secondary_to"
      },
      {
        "description": "NSO Action: Identify the which of the nodes in /high-availability/ha-node\n(if any) corresponds to the local NCS instance (path: /ncs:high-availability/local-node-id)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_high_availability_local_node_id"
      },
      {
        "description": "NSO Action: Enable NCS built in HA and optionally assume a ha role\naccording to /high-availability/settings/start-up/\nparameters (path: /ncs:high-availability/enable)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_high_availability_enable"
      },
      {
        "description": "NSO Action: Disable NCS built in HA and assume a ha role none (path: /ncs:high-availability/disable)",
        "inputSchema": {
          "type": "object"
        },
        "name": "ncs_high_availability_disable"
      },
      {
        "description": "NSO Action: Toggle read-only mode, if the mode is 'true' no\nconfiguration changes can occur\n\nDEPRECATED: Use /system/read-only action instead. (path: /ncs:high-availability/read-only)",
        "inputSchema": {
          "properties": {
            "mode": {
              "description": "mode",
              "type": "boolean"
            }
          },
          "type": "object"
        },
        "name": "ncs_high_availability_read_only"
      },
      {
        "description": "NSO Action: Select module for including in the NED. Selecting the module\nautomatically starts download of the module and all of its\nsubmodules in background. Certain other dependencies are also\nselected by default, see option 'no-dependencies' below. (path: /tnnb:netconf-ned-builder/project/module/select)",
        "inputSchema": {
          "properties": {
            "__key__module__name": {
              "description": "Key for 'module' list in action path - The YANG module or submodule name.",
              "type": "string",
              "x-list-tag": "module",
              "x-path-key": true
            },
            "__key__module__revision": {
              "description": "Key for 'module' list in action path - The YANG module or submodule revision date.\nA zero-length string is used if no revision statement\nis present in the YANG module or submodule.",
              "type": "string",
              "x-list-tag": "module",
              "x-path-key": true
            },
            "__key__project__family-name": {
              "description": "Key for 'project' list in action path - NED family name",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "__key__project__major-version": {
              "description": "Key for 'project' list in action path - NED major version",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "no-dependencies": {
              "description": "Do not select module's dependencies automatically. By default\nknown deviations and impored modules are automatically\nselected. This option is useful for scripting.\n\nSubmodules are always selected if there are any, regardless\nof this option being set.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__project__family-name",
            "__key__project__major-version",
            "__key__module__name",
            "__key__module__revision"
          ],
          "type": "object"
        },
        "name": "tnnb_netconf_ned_builder_project_module_select"
      },
      {
        "description": "NSO Action: Deselecting the module removes the selection mark, but does not\nremove the YANG file if it has already been downloaded.\nA deselected module is not included in the NED.\n\nUnlike action 'select', this action does not check the\ndependencies between the modules. It only deselects this module\nand its submodules, but not any modules depending on it. (path: /tnnb:netconf-ned-builder/project/module/deselect)",
        "inputSchema": {
          "properties": {
            "__key__module__name": {
              "description": "Key for 'module' list in action path - The YANG module or submodule name.",
              "type": "string",
              "x-list-tag": "module",
              "x-path-key": true
            },
            "__key__module__revision": {
              "description": "Key for 'module' list in action path - The YANG module or submodule revision date.\nA zero-length string is used if no revision statement\nis present in the YANG module or submodule.",
              "type": "string",
              "x-list-tag": "module",
              "x-path-key": true
            },
            "__key__project__family-name": {
              "description": "Key for 'project' list in action path - NED family name",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "__key__project__major-version": {
              "description": "Key for 'project' list in action path - NED major version",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            }
          },
          "required": [
            "__key__project__family-name",
            "__key__project__major-version",
            "__key__module__name",
            "__key__module__revision"
          ],
          "type": "object"
        },
        "name": "tnnb_netconf_ned_builder_project_module_deselect"
      },
      {
        "description": "NSO Action: This action initiates connection to the device and collects\ninformation about the supported data models from capabilities and\nietf-yang-library data model, as well as schemas available through\nietf-netconf-monitoring data model. The result of this action is\nstored in the 'module' list. (path: /tnnb:netconf-ned-builder/project/fetch-module-list)",
        "inputSchema": {
          "properties": {
            "__key__project__family-name": {
              "description": "Key for 'project' list in action path - NED family name",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "__key__project__major-version": {
              "description": "Key for 'project' list in action path - NED major version",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "overwrite": {
              "description": "This leaf indiates that the list of modules should be re-fetched,\nleading to the current selection status being reset and current\ndownload cache being cleared.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__project__family-name",
            "__key__project__major-version"
          ],
          "type": "object"
        },
        "name": "tnnb_netconf_ned_builder_project_fetch_module_list"
      },
      {
        "description": "NSO Action: This action creates a minimal NED structure and runs the compiler\nto build the models for NCS. This NED does not have a netsim\ndirectory nor Makefile. It is adviced to avoid modifying such NED\nby manual intervention, but only by modifying the module selection in\nNCS and running this action again.\n\nIn case of success the compiled NED is stored in NCS state and may\nbe exported with the 'export-ned' action. In case of failure the NCS\nonly keeps the compiler output in CDB (see 'build-warning' and\n'build-error' leafs on modules and submodules and 'compiler-output'\nhidden leaf), but the actual copy of the failed NED is deleted.\n\nIn cases the NED might require more advanced intervention such as\nmodification of YANG files or making a netsim device, it is adviced\nto make a development NED using 'make-development-ned' action. (path: /tnnb:netconf-ned-builder/project/build-ned)",
        "inputSchema": {
          "properties": {
            "__key__project__family-name": {
              "description": "Key for 'project' list in action path - NED family name",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "__key__project__major-version": {
              "description": "Key for 'project' list in action path - NED major version",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "overwrite": {
              "description": "By default we will not overwrite an existing NED. This option\ntells NCS to delete the existing copy of the NED and try again.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__project__family-name",
            "__key__project__major-version"
          ],
          "type": "object"
        },
        "name": "tnnb_netconf_ned_builder_project_build_ned"
      },
      {
        "description": "NSO Action: This action creates a development NED package in the specified\nparent directory, but does not build it. The package needs to be\nbuilt separately by running 'make' in its src/ subdirectory. The\ndevelopment NED package supports netsim and the user has the freedom\nof making modifications to the YANG files or build process. (path: /tnnb:netconf-ned-builder/project/make-development-ned)",
        "inputSchema": {
          "properties": {
            "__key__project__family-name": {
              "description": "Key for 'project' list in action path - NED family name",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "__key__project__major-version": {
              "description": "Key for 'project' list in action path - NED major version",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "in-directory": {
              "description": "The NED directory will be created as subdirectory to the\nspecified one. The user must have write access to the specified\ndirectory.",
              "type": "string"
            },
            "overwrite": {
              "description": "If the file with the generated name already exists in the\nspecified directory, then replace it with the new one.\n\nIf the file exists in the directory and this option is not\nspecified, then the action will fail.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__project__family-name",
            "__key__project__major-version"
          ],
          "type": "object"
        },
        "name": "tnnb_netconf_ned_builder_project_make_development_ned"
      },
      {
        "description": "NSO Action: This action will export the NED previously built with 'build-ned'\naction in form of tarball. The action takes as input the target\ndirectory to write the tar-file into, and the actual file name is\ngenerated internally according to the naming convention\n'ncs-<version>-<ned family>-<ned version>.tar.gz'. (path: /tnnb:netconf-ned-builder/project/export-ned)",
        "inputSchema": {
          "properties": {
            "__key__project__family-name": {
              "description": "Key for 'project' list in action path - NED family name",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "__key__project__major-version": {
              "description": "Key for 'project' list in action path - NED major version",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "overwrite": {
              "description": "If the file with the generated name already exists in the\nspecified directory, then replace it with the new one.\n\nIf the file exists in the directory and this option is not\nspecified, then the action will fail.",
              "type": "boolean"
            },
            "to-directory": {
              "description": "The tar file containing the NED will be created in the specified\ndirectory. The user must have write access to the specified\ndirectory.",
              "type": "string"
            }
          },
          "required": [
            "__key__project__family-name",
            "__key__project__major-version"
          ],
          "type": "object"
        },
        "name": "tnnb_netconf_ned_builder_project_export_ned"
      },
      {
        "description": "NSO Action: Saves current selection with specified name under\n/netconf-ned-builder/profile list. The selection may be\nmodified, exported into XML file and loaded on another system\nor reused to make similar NED. (path: /tnnb:netconf-ned-builder/project/save-selection)",
        "inputSchema": {
          "properties": {
            "__key__project__family-name": {
              "description": "Key for 'project' list in action path - NED family name",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "__key__project__major-version": {
              "description": "Key for 'project' list in action path - NED major version",
              "type": "string",
              "x-list-tag": "project",
              "x-path-key": true
            },
            "no-revisions": {
              "description": "Save only module names as a profile, without revision data.",
              "type": "boolean"
            },
            "profile": {
              "description": "Name of the profile to save. The profile must not exist.",
              "type": "string"
            }
          },
          "required": [
            "__key__project__family-name",
            "__key__project__major-version"
          ],
          "type": "object"
        },
        "name": "tnnb_netconf_ned_builder_project_save_selection"
      },
      {
        "description": "NSO Action: Select the set of modules defined by this profile in the project\nindicated by the input parameters. (path: /tnnb:netconf-ned-builder/profile/apply)",
        "inputSchema": {
          "properties": {
            "__key__profile__name": {
              "description": "Key for 'profile' list in action path - The name of the profile.",
              "type": "string",
              "x-list-tag": "profile",
              "x-path-key": true
            },
            "best-effort": {
              "description": "Skip modules that do not exist in the project.",
              "type": "boolean"
            },
            "family-name": {
              "description": "Reference to the target project's family-name.",
              "type": "string"
            },
            "major-version": {
              "description": "Reference to the target project's major-version.",
              "type": "string"
            },
            "with-dependencies": {
              "description": "By default the list of modules configured in a profile is\nassumed to be exhaustive so the dependencies for the selected\nmodules are not selected. This option allows to select modules\nspecified by the profile and automatically select their\ndependencies.",
              "type": "boolean"
            }
          },
          "required": [
            "__key__profile__name"
          ],
          "type": "object"
        },
        "name": "tnnb_netconf_ned_builder_profile_apply"
      },
      {
        "description": "NSO Action: Remove log entries (path: /bgpmgr:bgpmgr/log/purge)",
        "inputSchema": {
          "properties": {
            "__key__bgpmgr__name": {
              "description": "Key for 'bgpmgr' list in action path - Unique service id",
              "type": "string",
              "x-list-tag": "bgpmgr",
              "x-path-key": true
            },
            "level": {
              "description": "level",
              "enum": [
                "error",
                "warn",
                "info",
                "debug",
                "trace",
                "all"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "1": "all",
                "2": "trace",
                "3": "debug",
                "4": "info",
                "5": "warn",
                "6": "error"
              }
            },
            "older-than": {
              "description": "older-than",
              "properties": {
                "days": {
                  "description": "days",
                  "type": "integer"
                },
                "hours": {
                  "description": "hours",
                  "type": "integer"
                },
                "minutes": {
                  "description": "minutes",
                  "type": "integer"
                },
                "seconds": {
                  "description": "seconds",
                  "type": "integer"
                },
                "weeks": {
                  "description": "weeks",
                  "type": "integer"
                }
              },
              "type": "object"
            },
            "type": {
              "description": "type",
              "type": "string"
            }
          },
          "required": [
            "__key__bgpmgr__name"
          ],
          "type": "object"
        },
        "name": "bgpmgr_bgpmgr_log_purge"
      },
      {
        "description": "NSO Action: Check if device configuration is according to the service (path: /bgpmgr:bgpmgr/check-sync)",
        "inputSchema": {
          "properties": {
            "__key__bgpmgr__name": {
              "description": "Key for 'bgpmgr' list in action path - Unique service id",
              "type": "string",
              "x-list-tag": "bgpmgr",
              "x-path-key": true
            },
            "deep": {
              "description": "deep",
              "type": "boolean"
            },
            "no-lsa": {
              "description": "no-lsa",
              "type": "boolean"
            },
            "outformat": {
              "description": "outformat",
              "enum": [
                "cli-c",
                "boolean",
                "native",
                "xml",
                "cli"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "cli",
                "1": "xml",
                "2": "native",
                "3": "boolean",
                "4": "cli-c"
              }
            },
            "shallow": {
              "description": "shallow",
              "type": "boolean"
            },
            "suppress-positive-result": {
              "description": "Return list only contains negatives",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "use-lsa",
              "type": "boolean"
            },
            "with-service-meta-data": {
              "description": "with-service-meta-data",
              "type": "boolean"
            }
          },
          "required": [
            "__key__bgpmgr__name"
          ],
          "type": "object"
        },
        "name": "bgpmgr_bgpmgr_check_sync"
      },
      {
        "description": "NSO Action: Check if device configuration is according to the service (path: /bgpmgr:bgpmgr/deep-check-sync)",
        "inputSchema": {
          "properties": {
            "__key__bgpmgr__name": {
              "description": "Key for 'bgpmgr' list in action path - Unique service id",
              "type": "string",
              "x-list-tag": "bgpmgr",
              "x-path-key": true
            },
            "no-lsa": {
              "description": "no-lsa",
              "type": "boolean"
            },
            "no-wait-for-lock": {
              "description": "no-wait-for-lock",
              "type": "boolean"
            },
            "outformat": {
              "description": "outformat",
              "enum": [
                "cli-c",
                "boolean",
                "xml",
                "cli"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "cli",
                "1": "xml",
                "2": "boolean",
                "3": "cli-c"
              }
            },
            "suppress-positive-result": {
              "description": "Return list only contains negatives",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "use-lsa",
              "type": "boolean"
            },
            "wait-for-lock": {
              "description": "wait-for-lock",
              "properties": {
                "infinity": {
                  "description": "infinity",
                  "type": "boolean"
                },
                "timeout": {
                  "description": "timeout",
                  "type": "integer"
                }
              },
              "type": "object"
            }
          },
          "required": [
            "__key__bgpmgr__name"
          ],
          "type": "object"
        },
        "name": "bgpmgr_bgpmgr_deep_check_sync"
      },
      {
        "description": "NSO Action: Run/Dry-run the service logic again (path: /bgpmgr:bgpmgr/re-deploy)",
        "inputSchema": {
          "properties": {
            "__key__bgpmgr__name": {
              "description": "Key for 'bgpmgr' list in action path - Unique service id",
              "type": "string",
              "x-list-tag": "bgpmgr",
              "x-path-key": true
            },
            "comment": {
              "description": "comment",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "async",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "atomic",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "block-others",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "bypass",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "error-option",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "lock",
                  "type": "boolean"
                },
                "sync": {
                  "description": "sync",
                  "properties": {
                    "infinity": {
                      "description": "infinity",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "timeout",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "id",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "confirm-network-state",
              "properties": {
                "compare": {
                  "description": "compare",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "re-deploy-all",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "re-evaluate-policies",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "deep": {
              "description": "deep",
              "type": "boolean"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                },
                "with-service-meta-data": {
                  "description": "with-service-meta-data",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "label": {
              "description": "label",
              "type": "string"
            },
            "no-lsa": {
              "description": "no-lsa",
              "type": "boolean"
            },
            "no-networking": {
              "description": "no-networking",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "no-out-of-sync-check",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "no-overwrite",
              "properties": {
                "compare": {
                  "description": "compare",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "no-revision-drop",
              "type": "boolean"
            },
            "reconcile": {
              "description": "reconcile",
              "properties": {
                "attach-non-service-config": {
                  "description": "attach-non-service-config",
                  "type": "boolean"
                },
                "detach-non-service-config": {
                  "description": "detach-non-service-config",
                  "type": "boolean"
                },
                "discard-non-service-config": {
                  "description": "discard-non-service-config",
                  "type": "boolean"
                },
                "exclude": {
                  "description": "exclude (array of LIST)",
                  "items": {
                    "type": "string"
                  },
                  "type": "array"
                },
                "include": {
                  "description": "include (array of LIST)",
                  "items": {
                    "type": "string"
                  },
                  "type": "array"
                },
                "keep-non-service-config": {
                  "description": "keep-non-service-config",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "shallow": {
              "description": "shallow",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "use-lsa",
              "type": "boolean"
            }
          },
          "required": [
            "__key__bgpmgr__name"
          ],
          "type": "object"
        },
        "name": "bgpmgr_bgpmgr_re_deploy"
      },
      {
        "description": "NSO Action: Reactive re-deploy of service logic (path: /bgpmgr:bgpmgr/reactive-re-deploy)",
        "inputSchema": {
          "properties": {
            "__key__bgpmgr__name": {
              "description": "Key for 'bgpmgr' list in action path - Unique service id",
              "type": "string",
              "x-list-tag": "bgpmgr",
              "x-path-key": true
            },
            "sync": {
              "description": "sync",
              "type": "boolean"
            }
          },
          "required": [
            "__key__bgpmgr__name"
          ],
          "type": "object"
        },
        "name": "bgpmgr_bgpmgr_reactive_re_deploy"
      },
      {
        "description": "NSO Action: Mark the service as changed (path: /bgpmgr:bgpmgr/touch)",
        "inputSchema": {
          "properties": {
            "__key__bgpmgr__name": {
              "description": "Key for 'bgpmgr' list in action path - Unique service id",
              "type": "string",
              "x-list-tag": "bgpmgr",
              "x-path-key": true
            }
          },
          "required": [
            "__key__bgpmgr__name"
          ],
          "type": "object"
        },
        "name": "bgpmgr_bgpmgr_touch"
      },
      {
        "description": "NSO Action: Get the data this service created (path: /bgpmgr:bgpmgr/get-modifications)",
        "inputSchema": {
          "properties": {
            "__key__bgpmgr__name": {
              "description": "Key for 'bgpmgr' list in action path - Unique service id",
              "type": "string",
              "x-list-tag": "bgpmgr",
              "x-path-key": true
            },
            "deep": {
              "description": "deep",
              "type": "boolean"
            },
            "forward": {
              "description": "forward",
              "properties": {
                "only-out-of-band": {
                  "description": "only-out-of-band",
                  "type": "boolean"
                },
                "only-service": {
                  "description": "only-service",
                  "type": "boolean"
                },
                "with-out-of-band": {
                  "description": "with-out-of-band",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "no-lsa": {
              "description": "no-lsa",
              "type": "boolean"
            },
            "outformat": {
              "description": "outformat",
              "enum": [
                "cli-c",
                "xml",
                "cli"
              ],
              "type": "string",
              "x-enum-ordinals": {
                "0": "cli",
                "1": "xml",
                "4": "cli-c"
              }
            },
            "reverse": {
              "description": "reverse",
              "type": "boolean"
            },
            "shallow": {
              "description": "shallow",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "use-lsa",
              "type": "boolean"
            }
          },
          "required": [
            "__key__bgpmgr__name"
          ],
          "type": "object"
        },
        "name": "bgpmgr_bgpmgr_get_modifications"
      },
      {
        "description": "NSO Action: Undo the effects of the service (path: /bgpmgr:bgpmgr/un-deploy)",
        "inputSchema": {
          "properties": {
            "__key__bgpmgr__name": {
              "description": "Key for 'bgpmgr' list in action path - Unique service id",
              "type": "string",
              "x-list-tag": "bgpmgr",
              "x-path-key": true
            },
            "comment": {
              "description": "comment",
              "type": "string"
            },
            "commit-queue": {
              "description": "commit-queue",
              "properties": {
                "async": {
                  "description": "async",
                  "type": "boolean"
                },
                "atomic": {
                  "description": "atomic",
                  "type": "boolean"
                },
                "block-others": {
                  "description": "block-others",
                  "type": "boolean"
                },
                "bypass": {
                  "description": "bypass",
                  "type": "boolean"
                },
                "error-option": {
                  "description": "error-option",
                  "enum": [
                    "stop-on-error",
                    "rollback-on-error",
                    "continue-on-error"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "continue-on-error",
                    "1": "rollback-on-error",
                    "2": "stop-on-error"
                  }
                },
                "lock": {
                  "description": "lock",
                  "type": "boolean"
                },
                "sync": {
                  "description": "sync",
                  "properties": {
                    "infinity": {
                      "description": "infinity",
                      "type": "boolean"
                    },
                    "timeout": {
                      "description": "timeout",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                },
                "unlock": {
                  "description": "unlock",
                  "properties": {
                    "id": {
                      "description": "id",
                      "type": "integer"
                    }
                  },
                  "type": "object"
                }
              },
              "type": "object"
            },
            "confirm-network-state": {
              "description": "confirm-network-state",
              "properties": {
                "compare": {
                  "description": "compare",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-and-full-read-set",
                    "1": "write-and-service-read-set"
                  }
                },
                "re-deploy-all": {
                  "description": "re-deploy-all",
                  "type": "boolean"
                },
                "re-evaluate-policies": {
                  "description": "re-evaluate-policies",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "dry-run": {
              "description": "dry-run",
              "properties": {
                "outformat": {
                  "description": "outformat",
                  "enum": [
                    "cli-c",
                    "native",
                    "xml",
                    "cli"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "cli",
                    "1": "xml",
                    "2": "native",
                    "4": "cli-c"
                  }
                },
                "with-service-meta-data": {
                  "description": "with-service-meta-data",
                  "type": "boolean"
                }
              },
              "type": "object"
            },
            "ignore-refcount": {
              "description": "ignore-refcount",
              "type": "boolean"
            },
            "label": {
              "description": "label",
              "type": "string"
            },
            "no-lsa": {
              "description": "no-lsa",
              "type": "boolean"
            },
            "no-networking": {
              "description": "no-networking",
              "type": "boolean"
            },
            "no-out-of-sync-check": {
              "description": "no-out-of-sync-check",
              "type": "boolean"
            },
            "no-overwrite": {
              "description": "no-overwrite",
              "properties": {
                "compare": {
                  "description": "compare",
                  "enum": [
                    "write-and-service-read-set",
                    "write-and-full-read-set",
                    "write-set-only"
                  ],
                  "type": "string",
                  "x-enum-ordinals": {
                    "0": "write-set-only",
                    "1": "write-and-full-read-set",
                    "2": "write-and-service-read-set"
                  }
                }
              },
              "type": "object"
            },
            "no-revision-drop": {
              "description": "no-revision-drop",
              "type": "boolean"
            },
            "use-lsa": {
              "description": "use-lsa",
              "type": "boolean"
            }
          },
          "required": [
            "__key__bgpmgr__name"
          ],
          "type": "object"
        },
        "name": "bgpmgr_bgpmgr_un_deploy"
      },
      {
        "description": "NSO Action: Re-encrypt all encrypted values with a new set of keys (path: /keyrotation:key-rotation/apply-new-keys)",
        "inputSchema": {
          "properties": {
            "new-key-generation": {
              "description": "new-key-generation",
              "type": "integer"
            },
            "wait-commit-queue": {
              "description": "If set to 'empty', wait until commit queue is empty.\n\nIf set to an integer value, wait that many seconds until\nthe commit queue is empty. Fail if the commit queue is\nnot empty by then.\n\nIf not set, fail if commit queue is not empty.",
              "type": "string"
            }
          },
          "type": "object"
        },
        "name": "keyrotation_key_rotation_apply_new_keys"
      },
      {
        "description": "NSO Action: Display the currently active generation. (path: /keyrotation:key-rotation/get-active-generation)",
        "inputSchema": {
          "type": "object"
        },
        "name": "keyrotation_key_rotation_get_active_generation"
      },
      {
        "description": "NSO Action: Request password change (path: /aaa:aaa/authentication/users/user/change-password)",
        "inputSchema": {
          "properties": {
            "__key__user__name": {
              "description": "Key for 'user' list in action path - Login name of the user",
              "type": "string",
              "x-list-tag": "user",
              "x-path-key": true
            },
            "confirm-password": {
              "description": "Confirm New password",
              "type": "string"
            },
            "new-password": {
              "description": "New password",
              "type": "string"
            },
            "old-password": {
              "description": "Old password",
              "type": "string"
            }
          },
          "required": [
            "__key__user__name"
          ],
          "type": "object"
        },
        "name": "aaa_aaa_authentication_users_user_change_password"
      },
      {
        "description": "[NSO Service] Create a new bgpmgr service instance. Service: bgpmgr. Available parameters: name (BUF), dev1 (BUF), dev2 (BUF), dev1-as (UINT16), dev2-as (UINT16), /bgpmgr:bgpmgr/log/purge (action), /bgpmgr:bgpmgr/check-sync (action), /bgpmgr:bgpmgr/deep-check-sync (action), /bgpmgr:bgpmgr/re-deploy (action), /bgpmgr:bgpmgr/reactive-re-deploy (action) and 3 more (path: /bgpmgr:bgpmgr). Supports dry-run preview (__commit_dry_run=true) to show changes without applying, commit-queue, no-networking, and other NSO commit options. Available actions: purge, check-sync, deep-check-sync, re-deploy, reactive-re-deploy, touch, get-modifications, un-deploy",
        "inputSchema": {
          "properties": {
            "__commit_dry_run": {
              "description": "If true, preview changes without applying (commit dry-run). Returns the configuration diff that would be pushed to devices.",
              "type": "boolean"
            },
            "__commit_dry_run_format": {
              "default": "cli",
              "description": "Output format for dry-run results",
              "enum": [
                "cli",
                "xml",
                "native"
              ],
              "type": "string"
            },
            "__commit_no_deploy": {
              "description": "If true, skip service re-deploy during commit",
              "type": "boolean"
            },
            "__commit_no_networking": {
              "description": "If true, commit to CDB only - do not push configuration to devices",
              "type": "boolean"
            },
            "__commit_no_out_of_sync_check": {
              "description": "If true, skip the out-of-sync check before commit",
              "type": "boolean"
            },
            "__commit_no_overwrite": {
              "description": "If true, fail if device config was modified out-of-band",
              "type": "boolean"
            },
            "__commit_no_revision_drop": {
              "description": "If true, do not drop YANG revision info during commit",
              "type": "boolean"
            },
            "__commit_queue": {
              "description": "Commit-queue mode (omit for direct commit)",
              "enum": [
                "async",
                "sync",
                "bypass"
              ],
              "type": "string"
            },
            "__commit_queue_atomic": {
              "description": "If true, make the commit-queue transaction atomic across devices",
              "type": "boolean"
            },
            "__commit_queue_timeout": {
              "description": "Timeout in seconds for commit-queue sync mode",
              "type": "integer"
            },
            "dev1": {
              "description": "dev1 (BUF)",
              "type": "string"
            },
            "dev1-as": {
              "description": "dev1-as (UINT16)",
              "type": "integer"
            },
            "dev2": {
              "description": "dev2 (BUF)",
              "type": "string"
            },
            "dev2-as": {
              "description": "dev2-as (UINT16)",
              "type": "integer"
            },
            "name": {
              "description": "name - List key (key)",
              "type": "string"
            }
          },
          "required": [
            "name"
          ],
          "type": "object"
        },
        "name": "bgpmgr_bgpmgr_create"
      },
      {
        "description": "[NSO Service] Update an existing bgpmgr service instance. Service: bgpmgr. Available parameters: name (BUF), dev1 (BUF), dev2 (BUF), dev1-as (UINT16), dev2-as (UINT16), /bgpmgr:bgpmgr/log/purge (action), /bgpmgr:bgpmgr/check-sync (action), /bgpmgr:bgpmgr/deep-check-sync (action), /bgpmgr:bgpmgr/re-deploy (action), /bgpmgr:bgpmgr/reactive-re-deploy (action) and 3 more (path: /bgpmgr:bgpmgr). Supports dry-run preview (__commit_dry_run=true) to show changes without applying, commit-queue, no-networking, and other NSO commit options. Available actions: purge, check-sync, deep-check-sync, re-deploy, reactive-re-deploy, touch, get-modifications, un-deploy",
        "inputSchema": {
          "properties": {
            "__commit_dry_run": {
              "description": "If true, preview changes without applying (commit dry-run). Returns the configuration diff that would be pushed to devices.",
              "type": "boolean"
            },
            "__commit_dry_run_format": {
              "default": "cli",
              "description": "Output format for dry-run results",
              "enum": [
                "cli",
                "xml",
                "native"
              ],
              "type": "string"
            },
            "__commit_no_deploy": {
              "description": "If true, skip service re-deploy during commit",
              "type": "boolean"
            },
            "__commit_no_networking": {
              "description": "If true, commit to CDB only - do not push configuration to devices",
              "type": "boolean"
            },
            "__commit_no_out_of_sync_check": {
              "description": "If true, skip the out-of-sync check before commit",
              "type": "boolean"
            },
            "__commit_no_overwrite": {
              "description": "If true, fail if device config was modified out-of-band",
              "type": "boolean"
            },
            "__commit_no_revision_drop": {
              "description": "If true, do not drop YANG revision info during commit",
              "type": "boolean"
            },
            "__commit_queue": {
              "description": "Commit-queue mode (omit for direct commit)",
              "enum": [
                "async",
                "sync",
                "bypass"
              ],
              "type": "string"
            },
            "__commit_queue_atomic": {
              "description": "If true, make the commit-queue transaction atomic across devices",
              "type": "boolean"
            },
            "__commit_queue_timeout": {
              "description": "Timeout in seconds for commit-queue sync mode",
              "type": "integer"
            },
            "dev1": {
              "description": "dev1 (BUF)",
              "type": "string"
            },
            "dev1-as": {
              "description": "dev1-as (UINT16)",
              "type": "integer"
            },
            "dev2": {
              "description": "dev2 (BUF)",
              "type": "string"
            },
            "dev2-as": {
              "description": "dev2-as (UINT16)",
              "type": "integer"
            },
            "name": {
              "description": "name - List key (key)",
              "type": "string"
            }
          },
          "required": [
            "name"
          ],
          "type": "object"
        },
        "name": "bgpmgr_bgpmgr_update"
      },
      {
        "description": "[NSO Service] Delete a bgpmgr service instance. Service: bgpmgr. Available parameters: name (BUF), dev1 (BUF), dev2 (BUF), dev1-as (UINT16), dev2-as (UINT16), /bgpmgr:bgpmgr/log/purge (action), /bgpmgr:bgpmgr/check-sync (action), /bgpmgr:bgpmgr/deep-check-sync (action), /bgpmgr:bgpmgr/re-deploy (action), /bgpmgr:bgpmgr/reactive-re-deploy (action) and 3 more (path: /bgpmgr:bgpmgr). Supports dry-run preview (__commit_dry_run=true) to show changes without applying, commit-queue, no-networking, and other NSO commit options. Available actions: purge, check-sync, deep-check-sync, re-deploy, reactive-re-deploy, touch, get-modifications, un-deploy",
        "inputSchema": {
          "properties": {
            "__commit_dry_run": {
              "description": "If true, preview changes without applying (commit dry-run). Returns the configuration diff that would be pushed to devices.",
              "type": "boolean"
            },
            "__commit_dry_run_format": {
              "default": "cli",
              "description": "Output format for dry-run results",
              "enum": [
                "cli",
                "xml",
                "native"
              ],
              "type": "string"
            },
            "__commit_no_deploy": {
              "description": "If true, skip service re-deploy during commit",
              "type": "boolean"
            },
            "__commit_no_networking": {
              "description": "If true, commit to CDB only - do not push configuration to devices",
              "type": "boolean"
            },
            "__commit_no_out_of_sync_check": {
              "description": "If true, skip the out-of-sync check before commit",
              "type": "boolean"
            },
            "__commit_no_overwrite": {
              "description": "If true, fail if device config was modified out-of-band",
              "type": "boolean"
            },
            "__commit_no_revision_drop": {
              "description": "If true, do not drop YANG revision info during commit",
              "type": "boolean"
            },
            "__commit_queue": {
              "description": "Commit-queue mode (omit for direct commit)",
              "enum": [
                "async",
                "sync",
                "bypass"
              ],
              "type": "string"
            },
            "__commit_queue_atomic": {
              "description": "If true, make the commit-queue transaction atomic across devices",
              "type": "boolean"
            },
            "__commit_queue_timeout": {
              "description": "Timeout in seconds for commit-queue sync mode",
              "type": "integer"
            },
            "name": {
              "description": "name - List key",
              "type": "string"
            }
          },
          "required": [
            "name"
          ],
          "type": "object"
        },
        "name": "bgpmgr_bgpmgr_delete"
      },
      {
        "description": "[NSO Device] Synchronize the config by pulling from the device (path: /devices/device/sync-from)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Device name",
              "type": "string"
            }
          },
          "required": [
            "device"
          ],
          "type": "object"
        },
        "name": "devices_device_sync_from"
      },
      {
        "description": "[NSO Device] Check if the NCS config is in sync with the device (path: /devices/device/check-sync)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Device name",
              "type": "string"
            }
          },
          "required": [
            "device"
          ],
          "type": "object"
        },
        "name": "devices_device_check_sync"
      },
      {
        "description": "[NSO Device] Compare the actual device config with the NCS copy (path: /devices/device/compare-config)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Device name",
              "type": "string"
            }
          },
          "required": [
            "device"
          ],
          "type": "object"
        },
        "name": "devices_device_compare_config"
      },
      {
        "description": "[NSO Device] Connect to the device (path: /devices/device/connect)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Device name",
              "type": "string"
            }
          },
          "required": [
            "device"
          ],
          "type": "object"
        },
        "name": "devices_device_connect"
      },
      {
        "description": "[NSO Device] Close all sessions to the device (path: /devices/device/disconnect)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Device name",
              "type": "string"
            }
          },
          "required": [
            "device"
          ],
          "type": "object"
        },
        "name": "devices_device_disconnect"
      },
      {
        "description": "[NSO Device] ICMP ping the device (path: /devices/device/ping)",
        "inputSchema": {
          "properties": {
            "device": {
              "description": "Device name",
              "type": "string"
            }
          },
          "required": [
            "device"
          ],
          "type": "object"
        },
        "name": "devices_device_ping"
      },
      {
        "description": "[NSO Scheduler] Create a scheduled task. Supports cron expressions (e.g., '0 2 1 * *' for 2 AM on 1st of each month) or one-time date-time triggers. Supports dry-run preview (__commit_dry_run=true) to show changes without applying, commit-queue, no-networking, and other NSO commit options",
        "inputSchema": {
          "properties": {
            "action_name": {
              "description": "Name of the action to invoke, e.g., 'sync-from', 'purge'",
              "type": "string"
            },
            "action_node": {
              "description": "XPath instance-identifier of the node to invoke the action on. Use XPath predicate syntax with square brackets, NOT curly braces. Examples: '/ncs:devices' for all devices, '/ncs:devices/device[name=\"ce0\"]' for a specific device, '/ncs:devices/commit-queue/completed' for commit-queue purge",
              "type": "string"
            },
            "action_params": {
              "description": "Action input parameters in XML format",
              "type": "string"
            },
            "enabled": {
              "default": true,
              "description": "Whether the task is enabled (default: true)",
              "type": "boolean"
            },
            "name": {
              "description": "Unique name for the task",
              "type": "string"
            },
            "schedule": {
              "description": "Cron expression (minute hour day-of-month month day-of-week), e.g., '0 2 * * *' for daily at 2 AM",
              "type": "string"
            },
            "time": {
              "description": "One-time trigger as RFC 3339 date-time with explicit timezone offset (e.g., '2025-06-01T02:00:00+00:00' for UTC). IMPORTANT: use '+00:00' for UTC, not '-00:00' which means unknown timezone in YANG. Use instead of schedule for one-shot tasks",
              "type": "string"
            }
          },
          "required": [
            "name",
            "action_node",
            "action_name"
          ],
          "type": "object"
        },
        "name": "scheduler_create_task"
      },
      {
        "description": "[NSO Scheduler] Delete a scheduled task by name.",
        "inputSchema": {
          "properties": {
            "name": {
              "description": "Name of the task to delete",
              "type": "string"
            }
          },
          "required": [
            "name"
          ],
          "type": "object"
        },
        "name": "scheduler_delete_task"
      },
      {
        "description": "Read NSO schema at a full keypath.",
        "inputSchema": {
          "properties": {
            "path": {
              "description": "Full keypath to read (e.g., /ncs:devices/device{device1})",
              "type": "string"
            }
          },
          "required": [
            "path"
          ],
          "type": "object"
        },
        "name": "nso_read_schema"
      },
      {
        "description": "Read NSO config data at a full keypath.",
        "inputSchema": {
          "properties": {
            "path": {
              "description": "Full keypath to read (e.g., /ncs:devices/device{device1})",
              "type": "string"
            }
          },
          "required": [
            "path"
          ],
          "type": "object"
        },
        "name": "nso_read_config"
      },
      {
        "description": "Read NSO operational data at a full keypath.",
        "inputSchema": {
          "properties": {
            "path": {
              "description": "Full keypath to read (e.g., /ncs:devices/device{device1})",
              "type": "string"
            }
          },
          "required": [
            "path"
          ],
          "type": "object"
        },
        "name": "nso_read_operational"
      },
      {
        "description": "[NSO Device] Onboard a new device: creates config, fetches SSH host keys (if applicable), connects, and syncs from network in one operation",
        "inputSchema": {
          "properties": {
            "address": {
              "description": "IP address or hostname",
              "type": "string"
            },
            "admin_state": {
              "description": "Admin state",
              "enum": [
                "unlocked",
                "southbound-locked",
                "locked"
              ],
              "type": "string"
            },
            "authgroup": {
              "description": "Authentication group name",
              "type": "string"
            },
            "description": {
              "description": "Device description",
              "type": "string"
            },
            "device_type": {
              "description": "Device type",
              "enum": [
                "cli",
                "netconf",
                "generic"
              ],
              "type": "string"
            },
            "name": {
              "description": "Device name",
              "type": "string"
            },
            "ned_id": {
              "description": "NED identity (e.g. cisco-ios-cli-6.107:cisco-ios-cli-6.107)",
              "type": "string"
            },
            "ned_settings": {
              "description": "NED-specific settings object. Structure varies per NED type. The top-level key should be the NED name (e.g. cisco-ios, cisco-iosxr) containing NED-specific configuration such as connection, proxy, read, and write settings.",
              "type": "object"
            },
            "port": {
              "description": "Management port",
              "type": "integer"
            },
            "protocol": {
              "description": "CLI protocol (default: ssh). Only relevant for cli device type",
              "enum": [
                "ssh",
                "telnet"
              ],
              "type": "string"
            }
          },
          "required": [
            "name",
            "address",
            "authgroup",
            "device_type",
            "ned_id"
          ],
          "type": "object"
        },
        "name": "nso_device_onboard"
      },
      {
        "description": "[NSO Device] Update an existing device configuration. Supports commit options (__commit_dry_run, __commit_no_networking, etc.)",
        "inputSchema": {
          "properties": {
            "address": {
              "description": "IP address or hostname",
              "type": "string"
            },
            "admin_state": {
              "description": "Admin state",
              "enum": [
                "unlocked",
                "southbound-locked",
                "locked"
              ],
              "type": "string"
            },
            "authgroup": {
              "description": "Authentication group name",
              "type": "string"
            },
            "description": {
              "description": "Device description",
              "type": "string"
            },
            "device_type": {
              "description": "Device type",
              "enum": [
                "cli",
                "netconf",
                "generic"
              ],
              "type": "string"
            },
            "name": {
              "description": "Device name (identifies the device to update)",
              "type": "string"
            },
            "ned_id": {
              "description": "NED identity",
              "type": "string"
            },
            "ned_settings": {
              "description": "NED-specific settings object. Structure varies per NED type. The top-level key should be the NED name (e.g. cisco-ios, cisco-iosxr) containing NED-specific configuration such as connection, proxy, read, and write settings.",
              "type": "object"
            },
            "port": {
              "description": "Management port",
              "type": "integer"
            },
            "protocol": {
              "description": "CLI protocol",
              "enum": [
                "ssh",
                "telnet"
              ],
              "type": "string"
            }
          },
          "required": [
            "name"
          ],
          "type": "object"
        },
        "name": "nso_device_update"
      },
      {
        "description": "[NSO Device] Remove a device from NSO. Supports commit options (__commit_dry_run, __commit_no_networking, etc.)",
        "inputSchema": {
          "properties": {
            "name": {
              "description": "Device name to remove",
              "type": "string"
            }
          },
          "required": [
            "name"
          ],
          "type": "object"
        },
        "name": "nso_device_remove"
      },
      {
        "description": "[NSO Authgroup] Create a new authentication group for device access. Must be created before onboarding devices that reference it",
        "inputSchema": {
          "properties": {
            "name": {
              "description": "Authentication group name",
              "type": "string"
            },
            "remote_name": {
              "description": "Remote device username (default-map)",
              "type": "string"
            },
            "remote_password": {
              "description": "Remote device password (default-map)",
              "type": "string"
            },
            "remote_secondary_password": {
              "description": "Enable/config mode password",
              "type": "string"
            }
          },
          "required": [
            "name",
            "remote_name",
            "remote_password"
          ],
          "type": "object"
        },
        "name": "nso_authgroup_create"
      },
      {
        "description": "[NSO Authgroup] Update an existing authentication group. Supports commit options (__commit_dry_run, etc.)",
        "inputSchema": {
          "properties": {
            "name": {
              "description": "Authentication group name (identifies the group to update)",
              "type": "string"
            },
            "remote_name": {
              "description": "Remote device username (default-map)",
              "type": "string"
            },
            "remote_password": {
              "description": "Remote device password (default-map)",
              "type": "string"
            },
            "remote_secondary_password": {
              "description": "Enable/config mode password",
              "type": "string"
            }
          },
          "required": [
            "name"
          ],
          "type": "object"
        },
        "name": "nso_authgroup_update"
      },
      {
        "description": "[NSO Authgroup] Delete an authentication group. Ensure no devices reference this group before deleting",
        "inputSchema": {
          "properties": {
            "name": {
              "description": "Authentication group name to delete",
              "type": "string"
            }
          },
          "required": [
            "name"
          ],
          "type": "object"
        },
        "name": "nso_authgroup_delete"
      }
    ]
  }
}
```
</details>

# Prompts
```


{
  "id": 1,
  "jsonrpc": "2.0",
  "result": {
    "prompts": [
      {
        "arguments": [
          {
            "description": "Service type in NSO",
            "name": "SERVICE_TYPE",
            "required": false
          },
          {
            "description": "Service name of failed service",
            "name": "SERVICE_NAME",
            "required": false
          }
        ],
        "description": "Analyze service error and recover",
        "name": "error_recovery"
      },
      {
        "arguments": [],
        "description": "Detect and clean up zombie service references",
        "name": "zombie_cleanup"
      },
      {
        "arguments": [
          {
            "description": "Unique identifier for the device in NSO",
            "name": "DEVICE_NAME",
            "required": false
          },
          {
            "description": "IP address or hostname of the device",
            "name": "DEVICE_ADDRESS",
            "required": false
          },
          {
            "description": "NED package to use (e.g. cisco-ios-cli)",
            "name": "DEVICE_TYPE",
            "required": false
          },
          {
            "description": "Authentication group name for device credentials",
            "name": "AUTH_GROUP",
            "required": false
          },
          {
            "description": "SSH port number (default: 22)",
            "name": "PORT",
            "required": false
          }
        ],
        "description": "Guide through adding and configuring a new device in NSO",
        "name": "device_onboard"
      },
      {
        "arguments": [
          {
            "description": "Name for the backup file",
            "name": "BACKUP_NAME",
            "required": false
          },
          {
            "description": "Path to save backup (optional)",
            "name": "BACKUP_PATH",
            "required": false
          },
          {
            "description": "Include rollback files",
            "name": "INCLUDE_ROLLBACK",
            "required": false
          },
          {
            "description": "Backup file to restore from",
            "name": "BACKUP_NAME",
            "required": false
          },
          {
            "description": "Preview changes before restoring",
            "name": "DRY_RUN",
            "required": false
          },
          {
            "description": "Optional: specific path to restore",
            "name": "RESTORE_PATH",
            "required": false
          },
          {
            "description": "Backup file to verify",
            "name": "BACKUP_NAME",
            "required": false
          }
        ],
        "description": "Backup and restore NSO configuration database (CDB)",
        "name": "cdb_backup"
      },
      {
        "arguments": [
          {
            "description": "Unique identifier for this scheduled task",
            "name": "TASK_NAME",
            "required": false
          },
          {
            "description": "Action to invoke (e.g. sync-from, check-sync, purge)",
            "name": "ACTION_NAME",
            "required": false
          },
          {
            "description": "XPath to the node to invoke the action on",
            "name": "ACTION_NODE",
            "required": false
          },
          {
            "description": "Target device name",
            "name": "DEVICE_NAME",
            "required": false
          }
        ],
        "description": "Create, manage, and delete scheduled tasks in NSO",
        "name": "schedule_task"
      },
      {
        "arguments": [],
        "description": "Apply same configuration change across multiple targets",
        "name": "bulk_change"
      },
      {
        "arguments": [
          {
            "description": "Service type in NSO",
            "name": "SERVICE_TYPE",
            "required": false
          },
          {
            "description": "Service name of failed service",
            "name": "SERVICE_NAME",
            "required": false
          }
        ],
        "description": "Create a service instance safely with minimal user input",
        "name": "service_creation"
      }
    ]
  }
}
```

# Resources
```

{
  "id": 1,
  "jsonrpc": "2.0",
  "result": {
    "resources": [
      {
        "description": "Operational state of global device settings",
        "mimeType": "text/plain",
        "name": "Device Global Settings",
        "uri": "nso://devices/global-settings"
      },
      {
        "description": "Display current zombies",
        "mimeType": "text/plain",
        "name": "NSO Zombies",
        "uri": "nso://operational/zombies/service"
      },
      {
        "description": "Service schema for bgpmgr. Service: bgpmgr. Available parameters: name (BUF), dev1 (BUF), dev2 (BUF), dev1-as (UINT16), dev2-as (UINT16), /bgpmgr:bgpmgr/log/purge (action), /bgpmgr:bgpmgr/check-sync (action), /bgpmgr:bgpmgr/deep-check-sync (action), /bgpmgr:bgpmgr/re-deploy (action), /bgpmgr:bgpmgr/reactive-re-deploy (action) and 3 more",
        "mimeType": "text/plain",
        "name": "Schema For Service Type bgpmgr",
        "uri": "nso://schema/bgpmgr"
      },
      {
        "description": "Service config for bgpmgr. Service: bgpmgr. Available parameters: name (BUF), dev1 (BUF), dev2 (BUF), dev1-as (UINT16), dev2-as (UINT16), /bgpmgr:bgpmgr/log/purge (action), /bgpmgr:bgpmgr/check-sync (action), /bgpmgr:bgpmgr/deep-check-sync (action), /bgpmgr:bgpmgr/re-deploy (action), /bgpmgr:bgpmgr/reactive-re-deploy (action) and 3 more",
        "mimeType": "text/plain",
        "name": "Configuration For All bgpmgr Services",
        "uri": "nso://bgpmgr"
      },
      {
        "description": "Service operational data for bgpmgr. Service: bgpmgr. Available parameters: name (BUF), dev1 (BUF), dev2 (BUF), dev1-as (UINT16), dev2-as (UINT16), /bgpmgr:bgpmgr/log/purge (action), /bgpmgr:bgpmgr/check-sync (action), /bgpmgr:bgpmgr/deep-check-sync (action), /bgpmgr:bgpmgr/re-deploy (action), /bgpmgr:bgpmgr/reactive-re-deploy (action) and 3 more",
        "mimeType": "text/plain",
        "name": "Operational Data For All bgpmgr Services",
        "uri": "nso://operational/bgpmgr"
      }
    ]
  }
}
```

# Resources/templates
```

{
  "id": 1,
  "jsonrpc": "2.0",
  "result": {
    "resourceTemplates": [
      {
        "description": "Configuration for device {name}",
        "mimeType": "text/plain",
        "name": "Device Configuration",
        "uriTemplate": "nso://devices/device{name}/config"
      },
      {
        "description": "Config and Settings for device {name}",
        "mimeType": "text/plain",
        "name": "Device Configuration and Settings",
        "uriTemplate": "nso://devices/device{name}"
      },
      {
        "description": "Display current zombies",
        "mimeType": "text/plain",
        "name": "NSO Zombies",
        "uriTemplate": "nso://operational/zombies/service{service_path}"
      },
      {
        "description": "Operational Data for device {name}",
        "mimeType": "text/plain",
        "name": "Device Operational Data",
        "uriTemplate": "nso://operational/devices/device{name}"
      },
      {
        "description": "Schema for path module",
        "mimeType": "text/plain",
        "name": "Schema for path module",
        "uriTemplate": "nso://schema/{path}"
      },
      {
        "description": "Service schema for bgpmgr. Service: bgpmgr. Available parameters: name (BUF), dev1 (BUF), dev2 (BUF), dev1-as (UINT16), dev2-as (UINT16), /bgpmgr:bgpmgr/log/purge (action), /bgpmgr:bgpmgr/check-sync (action), /bgpmgr:bgpmgr/deep-check-sync (action), /bgpmgr:bgpmgr/re-deploy (action), /bgpmgr:bgpmgr/reactive-re-deploy (action) and 3 more",
        "mimeType": "text/plain",
        "name": "Schema For Service Type bgpmgr",
        "uriTemplate": "nso://schema/bgpmgr{name}"
      },
      {
        "description": "Service config for bgpmgr. Service: bgpmgr. Available parameters: name (BUF), dev1 (BUF), dev2 (BUF), dev1-as (UINT16), dev2-as (UINT16), /bgpmgr:bgpmgr/log/purge (action), /bgpmgr:bgpmgr/check-sync (action), /bgpmgr:bgpmgr/deep-check-sync (action), /bgpmgr:bgpmgr/re-deploy (action), /bgpmgr:bgpmgr/reactive-re-deploy (action) and 3 more",
        "mimeType": "text/plain",
        "name": "Configuration For bgpmgr Service",
        "uriTemplate": "nso://bgpmgr{name}"
      },
      {
        "description": "Service operational data for bgpmgr. Service: bgpmgr. Available parameters: name (BUF), dev1 (BUF), dev2 (BUF), dev1-as (UINT16), dev2-as (UINT16), /bgpmgr:bgpmgr/log/purge (action), /bgpmgr:bgpmgr/check-sync (action), /bgpmgr:bgpmgr/deep-check-sync (action), /bgpmgr:bgpmgr/re-deploy (action), /bgpmgr:bgpmgr/reactive-re-deploy (action) and 3 more",
        "mimeType": "text/plain",
        "name": "Operational Data For bgpmgr Service",
        "uriTemplate": "nso://operational/bgpmgr{name}"
      }
    ]
  }
}
```

