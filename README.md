# FSP-NPC-DFS

Text-based-game protype/experiment created as a Flatiron School Students Present -project.

# General Idea
Player communicates with randomly generated NPC characters by typing on the commandline. Responses from the NPC are
based on simple word scoring + player's reputation + NPC's personality (hostile-friendly). 
The decision process uses these three scores and the decision tree gem to output a response. Certain keywords together with
a positive response from the NPC will give out information on what to ask next.

# How to run it
`$ ruby bin/run`  
Type in one of the options and hit enter: 

*  1) run -- game runs with only one interaction: Program exits after evaluating one sentence from the player  
*  2) gamerun -- continuous gameplay. Program only exits if the player types 'exit' on the commandline. Player can switch between NPCs by typing 'bye' con the commandline  
*  3) autorun -- AI speaks to the NPC by autogenerating text.  

# Related text files are all located in folder /lib/NPC-AI/data  
*  blacklist.txt => file for unsavory words  
*  whitelist.txt => file for words that give bonus points  
*  information.txt => keyword-response pairs for information offered by NPCs  
*  talk/*.txt => expressions for rudimentary conversations *note: these should be subsituted by real grammar and lang generation.  


