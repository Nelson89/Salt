#!/usr/bin/env bash
echo "Looking for keys"
salt-key -Ay
echo "Applying highstate"
sleep 4
salt '*' state.apply
echo "Show highstate"
salt '*' state.show_highstate
