// This code is generated using KSML (lucaelin.github.io/ksml)
// KSML-Source: ~PHZib3g+CiAgICA8aGJveD4KICAgICAgICA8bGFiZWwgc3R5bGU6Zm9udD0nIlJvYm90byBNb25vc3BhY2UiJyBzdHlsZTpmb250c2l6ZT0nMjAnPk1hbmV1dmVyLUNvbXB1dGVyPC9sYWJlbD4KICAgIDwvaGJveD4KICAgIDxoYm94PgogICAgICAgIDxsYWJlbD5TdGVlcmluZyBDb250cm9sczogPC9sYWJlbD48bGFiZWwgaWQ9J2N1cnJlbnRfc3RlZXJpbmcnPjwvbGFiZWw+CiAgICA8L2hib3g+CiAgICA8aGJveD4KICAgICAgICA8YnV0dG9uIGlkPSdzdGVlcmluZ19wcm9ncmFkZScgZXhjbHVzaXZlPSd0cnVlJz5QUk9HPC9idXR0b24+CiAgICAgICAgPGJ1dHRvbiBpZD0nc3RlZXJpbmdfcmV0cm9ncmFkZScgZXhjbHVzaXZlPSd0cnVlJz5SRVRSPC9idXR0b24+CiAgICAgICAgPGJ1dHRvbiBpZD0nc3RlZXJpbmdfbm9ybWFsJyBleGNsdXNpdmU9J3RydWUnPk5PUk08L2J1dHRvbj4KICAgICAgICA8YnV0dG9uIGlkPSdzdGVlcmluZ19hbnRpbm9ybWFsJyBleGNsdXNpdmU9J3RydWUnPkFOVEk8L2J1dHRvbj4KICAgICAgICA8YnV0dG9uIGlkPSdzdGVlcmluZ19yYWRpYWxpbicgZXhjbHVzaXZlPSd0cnVlJz5SRElOPC9idXR0b24+CiAgICAgICAgPGJ1dHRvbiBpZD0nc3RlZXJpbmdfcmFkaWFsb3V0JyBleGNsdXNpdmU9J3RydWUnPlJPVVQ8L2J1dHRvbj4KICAgICAgICA8YnV0dG9uIGlkPSdzdGVlcmluZ191bmxvY2snIGV4Y2x1c2l2ZT0ndHJ1ZSc+VU5MTzwvYnV0dG9uPiAgICAgICAgCiAgICA8L2hib3g+CiAgICA8aGJveD4KICAgICAgICA8bGFiZWw+QXV0byBidXJuIG1hbmV1dmVyOiA8L2xhYmVsPjxsYWJlbCBpZD0nYXV0b19idXJuJz48L2xhYmVsPgogICAgPC9oYm94PgogICAgPHZib3g+CiAgICAgICAgPGhib3g+CiAgICAgICAgICAgIDxidXR0b24gaWQ9J3J1bl9ub2RlJyBleGNsdXNpdmU9J3RydWUnPlNUQVJUPC9idXR0b24+CiAgICAgICAgICAgIDxsYWJlbD5hdXRvLiBleGVjdXRlIG5leHQgbm9kZSBidXJuPC9sYWJlbD4KICAgICAgICA8L2hib3g+CiAgICAgICAgPGhib3g+CiAgICAgICAgICAgIDxidXR0b24gaWQ9InN0b3Bfbm9kZSIgZXhjbHVzaXZlPSd0cnVlJz5TVE9QPC9idXR0b24+CiAgICAgICAgICAgIDxsYWJlbD5zdG9wIHJ1bm5pbmcgZXhlY3V0aW9uPC9sYWJlbD4KICAgICAgICA8L2hib3g+CiAgICA8L3Zib3g+CjwvdmJveD4=~
parameter node.
parameter ids is LEX().
  {
    local parent is node.
    local node is parent:addvbox().

    //attributes

    //childnodes
    {
      local parent is node.
      local node is parent:addhbox().

      //attributes

      //childnodes
      {
        local parent is node.
        local node is parent:addlabel().

        //attributes
        set node:style:font to "Roboto Monospace".
        set node:style:fontsize to 20.

        //childnodes
        set node:text to "Maneuver-Computer".
      }
    }
    {
      local parent is node.
      local node is parent:addhbox().

      //attributes

      //childnodes
      {
        local parent is node.
        local node is parent:addlabel().

        //attributes

        //childnodes
        set node:text to "Steering Controls:".
      }
      {
        local parent is node.
        local node is parent:addlabel().

        //attributes
        ids:ADD("current_steering", node).

        //childnodes
      }
    }
    {
      local parent is node.
      local node is parent:addhbox().

      //attributes

      //childnodes
      {
        local parent is node.
        local node is parent:addbutton().

        //attributes
        ids:ADD("steering_prograde", node).
        set node:exclusive to true.

        //childnodes
        set node:text to "PROG".
      }
      {
        local parent is node.
        local node is parent:addbutton().

        //attributes
        ids:ADD("steering_retrograde", node).
        set node:exclusive to true.

        //childnodes
        set node:text to "RETR".
      }
      {
        local parent is node.
        local node is parent:addbutton().

        //attributes
        ids:ADD("steering_normal", node).
        set node:exclusive to true.

        //childnodes
        set node:text to "NORM".
      }
      {
        local parent is node.
        local node is parent:addbutton().

        //attributes
        ids:ADD("steering_antinormal", node).
        set node:exclusive to true.

        //childnodes
        set node:text to "ANTI".
      }
      {
        local parent is node.
        local node is parent:addbutton().

        //attributes
        ids:ADD("steering_radialin", node).
        set node:exclusive to true.

        //childnodes
        set node:text to "RDIN".
      }
      {
        local parent is node.
        local node is parent:addbutton().

        //attributes
        ids:ADD("steering_radialout", node).
        set node:exclusive to true.

        //childnodes
        set node:text to "ROUT".
      }
      {
        local parent is node.
        local node is parent:addbutton().

        //attributes
        ids:ADD("steering_unlock", node).
        set node:exclusive to true.

        //childnodes
        set node:text to "UNLO".
      }
    }
    {
      local parent is node.
      local node is parent:addhbox().

      //attributes

      //childnodes
      {
        local parent is node.
        local node is parent:addlabel().

        //attributes

        //childnodes
        set node:text to "Auto burn maneuver:".
      }
      {
        local parent is node.
        local node is parent:addlabel().

        //attributes
        ids:ADD("auto_burn", node).

        //childnodes
      }
    }
    {
      local parent is node.
      local node is parent:addvbox().

      //attributes

      //childnodes
      {
        local parent is node.
        local node is parent:addhbox().

        //attributes

        //childnodes
        {
          local parent is node.
          local node is parent:addbutton().

          //attributes
          ids:ADD("run_node", node).
          set node:exclusive to true.

          //childnodes
          set node:text to "START".
        }
        {
          local parent is node.
          local node is parent:addlabel().

          //attributes

          //childnodes
          set node:text to "auto. execute next node burn".
        }
      }
      {
        local parent is node.
        local node is parent:addhbox().

        //attributes

        //childnodes
        {
          local parent is node.
          local node is parent:addbutton().

          //attributes
          ids:ADD("stop_node", node).
          set node:exclusive to true.

          //childnodes
          set node:text to "STOP".
        }
        {
          local parent is node.
          local node is parent:addlabel().

          //attributes

          //childnodes
          set node:text to "stop running execution".
        }
      }
    }
  }
