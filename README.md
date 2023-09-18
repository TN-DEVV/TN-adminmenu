# tn-adminmenu

An improved version of qb-adminmenu. With better logic and more features.

# Installation

1- import the sql
2- drag and drop the script in your [qb]
3- open qb-smallresources/server/log.lua and add this line
   ['admin'] = '', -- put your webhook to have admin logs

# Informations

all commands created by tn-adminmenu check if admin is on duty or not !
if you want to check adminduty in other script just do this

client side :

   local duty = exports('isAdminOnDuty', function() return isAdminOnDuty() end)
   if duty then -- check if the admin is on duty or not
      -- your code
   end

server side :

   local duty = exports('isAdminOnDuty', function(source) return isAdminOnDuty(source) end)
   if duty then -- check if the admin is on duty or not
      -- your code
   end

# Player Management

1. General Options
   - Kill
   - Revive
   - Freeze
   - Spectate
   - Go to
   - Bring
   - Bringback
   - Bringall
   - Sit in vehicle
   - Routingbucket
2. Administration
   - Kick
   - Ban
   - Permissions
3. Extra Options
   - Open Inventory
   - Give Clothing Menu
   - Give An Item
   - Play A Sound
   - Mute Player
4. Player Information List

# Dependencies

Makes usage of

- [qb-menu](https://github.com/qbcore-framework/qb-menu)
- [qb-input](https://github.com/qbcore-framework/qb-input)
- [interact-sound](https://github.com/qbcore-framework/interact-sound)
- [pma-voice](https://github.com/AvarianKnight/pma-voice)
