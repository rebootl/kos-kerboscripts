// This code is generated using KSML (lucaelin.github.io/ksml)
// KSML-Source: ~PHZib3g+CiAgPHZsYXlvdXQ+CiAgPGhib3g+CiAgICA8bGFiZWwgc3R5bGU6Zm9udD0nIlJvYm90byBNb25vc3BhY2UiJyBzdHlsZTpmb250c2l6ZT0nMjAnPkF1dG9waWxvdDwvbGFiZWw+CiAgICA8YnV0dG9uIGlkPSd0b2dnbGVfYXAnPk9uPC9idXR0b24+CiAgPC9oYm94PgogICAgPGhib3g+CiAgICAgICAgPGxhYmVsPktwPC9sYWJlbD4KICAgICAgICA8dGV4dGZpZWxkIGlkPSJrcF9pbnB1dCI+MC4wPC90ZXh0ZmllbGQ+CiAgICAgICAgPGxhYmVsPktpPC9sYWJlbD4KICAgICAgICA8dGV4dGZpZWxkIGlkPSJraV9pbnB1dCI+MC4wPC90ZXh0ZmllbGQ+CiAgICAgICAgPGxhYmVsPktkPC9sYWJlbD4KICAgICAgICA8dGV4dGZpZWxkIGlkPSJrZF9pbnB1dCI+MC4wPC90ZXh0ZmllbGQ+CiAgICAgIDwvaGJveD4KICAgICAgPC92bGF5b3V0PgogIDxoYm94PgogICAgPCEtLTxsYWJlbCBpZD0nbXllbGVtZW50JyBzdHlsZTpmb250PSciUm9ib3RvIE1vbm9zcGFjZSInIHN0eWxlOmZvbnRzaXplPScyMCc+CiAgICAgICZsdDtiJmd0O215bGFiZWwyIHJpY2ggdGV4dCZsdDsvYiZndDsKICAgIDwvbGFiZWw+LS0+CiAgICA8dmJveD4KICAgICAgPCEtLTxoYm94PgogICAgICAgIDxsYWJlbCBzdHlsZTpmb250c2l6ZT0nMjAnPlRhcmdldCBBbHRpdHVkZTwvbGFiZWw+CiAgICAgICAgPHRleHRmaWVsZCBpZD0idGFyZ2V0X2FsdGl0dWRlIj41MDAwLjA8L3RleHRmaWVsZD4KICAgICAgPC9oYm94Pi0tPgogICAgICA8aGJveD4KICAgICAgICA8bGFiZWwgc3R5bGU6Zm9udHNpemU9JzIwJz5UYXJnZXQgQ2xpbWJpbmcgUmF0ZTwvbGFiZWw+CiAgICAgICAgPHRleHRmaWVsZCBpZD0idGFyZ2V0X2NyIj4wLjA8L3RleHRmaWVsZD4KICAgICAgPC9oYm94PgogICAgICA8aGJveD4KICAgICAgICA8bGFiZWw+Q3VycmVudCBDbGltYmluZyBSYXRlOjwvbGFiZWw+CiAgICAgICAgPGxhYmVsIGlkPSJjdXJyX2NyIj4wLjA8L2xhYmVsPgogICAgICA8L2hib3g+CiAgICAgIDxoYm94PgogICAgICAgIDxidXR0b24gaWQ9J3VwZGF0ZV9hcCc+VXBkYXRlIFRhcmdldDwvYnV0dG9uPgogICAgICA8L2hib3g+CiAgICA8L3Zib3g+CiAgPC9oYm94Pgo8L3Zib3g+~
parameter node.
parameter ids is LEX().
  {
    local parent is node.
    local node is parent:addvbox().

    //attributes

    //childnodes
    {
      local parent is node.
      local node is parent:addvlayout().

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
          set node:text to "Autopilot".
        }
        {
          local parent is node.
          local node is parent:addbutton().

          //attributes
          ids:ADD("toggle_ap", node).

          //childnodes
          set node:text to "On".
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
          set node:text to "Kp".
        }
        {
          local parent is node.
          local node is parent:addtextfield().

          //attributes
          ids:ADD("kp_input", node).

          //childnodes
          set node:text to "0.0".
        }
        {
          local parent is node.
          local node is parent:addlabel().

          //attributes

          //childnodes
          set node:text to "Ki".
        }
        {
          local parent is node.
          local node is parent:addtextfield().

          //attributes
          ids:ADD("ki_input", node).

          //childnodes
          set node:text to "0.0".
        }
        {
          local parent is node.
          local node is parent:addlabel().

          //attributes

          //childnodes
          set node:text to "Kd".
        }
        {
          local parent is node.
          local node is parent:addtextfield().

          //attributes
          ids:ADD("kd_input", node).

          //childnodes
          set node:text to "0.0".
        }
      }
    }
    {
      local parent is node.
      local node is parent:addhbox().

      //attributes

      //childnodes
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
            set node:style:fontsize to 20.

            //childnodes
            set node:text to "Target Climbing Rate".
          }
          {
            local parent is node.
            local node is parent:addtextfield().

            //attributes
            ids:ADD("target_cr", node).

            //childnodes
            set node:text to "0.0".
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
            set node:text to "Current Climbing Rate:".
          }
          {
            local parent is node.
            local node is parent:addlabel().

            //attributes
            ids:ADD("curr_cr", node).

            //childnodes
            set node:text to "0.0".
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
            ids:ADD("update_ap", node).

            //childnodes
            set node:text to "Update Target".
          }
        }
      }
    }
  }
