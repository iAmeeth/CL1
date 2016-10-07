import xml.etree.ElementTree as ET

tree= ET.parse('parsing_table.xml')
root=tree.getroot()

term=[]
non_term=[]
lsprod=[]
rsprod=[]
n=0    #no of states

for child in root:
   if(child.tag == "states"):
      n = int(child.text)
   elif(child.tag=="term"):
      term.append(child.text)
   elif(child.tag=="nterm"):
      non_term.append(child.text)
   elif(child.tag=="productions"):
        for ch in child:
          lsprod.append(ch[0].text)
          rsprod.append(ch[1].text)
   elif(child.tag=="actiontable"):
      action=[[] for x in range(n)]
      i=0
      for ch in child:
         for c in ch:
           action[i].append(c.text)
         i=i+1
 
   elif(child.tag=="gototable"):
      goto=[[] for x in range(n)] 
      i=0
      for ch in child:
         for c in ch:
            goto[i].append(c.text)
         i=i+1


nterm=len(term)
nnterm=len(non_term)
nprod=len(lsprod)

print("Terminals:    "),;print(term)
print("Non Terminals:    "),;print(non_term)

print("Grammar Productions are as follows:   ")
for i in range(nprod):
   print(lsprod[i]+" -> "+rsprod[i])


print("\nAction Table:  ")
for i in range(n):
  print("")
  for j in range(nterm):
     print(action[i][j]+"   "),
print("")
print("Goto Table:    ")
for i in range(n):
  print(" ")
  for j in range(nnterm):
    print(str(goto[i][j])+"   "),

while True:
  print("\nEnter input String:  "),
  istr=raw_input()
  iptr=0

  stack=['$',0]
  done = False
  while True:
    print("Stack :"),
    print(stack)
    stop=stack[len(stack)-1]
    if iptr >= len(istr):
    	done = True
    else:
    	isym=istr[iptr]
    isindex=term.index(isym)
    ac=action[stop][isindex]
    print("Action for stop="+str(stop)+" and input symbol index   "+str(isindex)+" is "+action[stop][isindex])
    if(ac=="Error"):
       print("Syntax Error!!!")
       break
    elif(done or ac=="Accept"):
       print("Correct Syntax!!")
       break
    elif("s" in ac):
       stack.append(isym)
       ns=ac.replace("s","")
       stack.append(int(ns))
       iptr=iptr+1
    elif("r" in ac):
       rrule=int(ac.replace("r",""))
       print("Reduce using rule  "+lsprod[rrule-1]+"  ->  "+rsprod[rrule-1])
       for i in range(2*len(rsprod[rrule-1])):
           stack.pop()
       print(stack)
       stack.append(lsprod[rrule-1])
       pstate=stack[len(stack)-2]
       ntindex=non_term.index(lsprod[rrule-1])
       nst=goto[pstate][ntindex]
       stack.append(int(nst))
       print(stack)
