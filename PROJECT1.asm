#------------- SAJA SHAREEF ------------------------
#------------- SHEREEN IBDAH------------------------
#---------------------------------------------------
################# Data segment #####################
#---------------------------------------------------

.data

    filename: .asciiz "Calendar.txt"
    buffer: .space 1500
    buffer2: .space 1500
    buffer3: .space 1500
    buffer4: .space 1500
     remove: .space 60
    menu_string: .asciiz "\nMenu:\n------------------------------------------------------\n1. View the calendar\n2. View Statistics\n3. Add New Appointment\n4. Delete an appointment\n5. Exit\n\nEnter your choice: \n"
    invaled: .asciiz "invaled input,please choose another choise\n"
    menu_option_1: .asciiz "\nView the calendar:\n1. per day\n2. per set of days\n3. for a slot from day\n\nEnter your choice: \n"
    per_day: .asciiz "\nWhat day of the month do you want?\n"
    message_dayDoesNotExist: .asciiz "--> This day does not have a calendar\n"
    per_set_of_days:   .asciiz  "Please enter the number of days :\n"
    menu_option_2 :  .asciiz "\n1. number of lectures (in hours) \n2. number of OH (in hours)\n3. the number of Meetings (in hour)\n4. average lectures per day\n5.the ratio between number of lectures (in hours) and number of OH (in hours)\n"
    starttime: .asciiz "\nEnter the start time for the slot\n"
    endtime: .asciiz "\nEnter the end time for the slot\n"
    errorslot: .asciiz "\ntime slot must be in 8AM-5PM Range\n"
    error2slot: .asciiz "\n End time must be after the start time\n" 
    numOfLec: .asciiz "\n Number of lectures (in hours) =  "
    numOfOH : .asciiz "\n Number of Office Hours (in hours) = "
    numOfM : .asciiz "\n Number of Meetings (in hours) = "
    avglectures: .asciiz "\n Average lectures per day = "
    ratio : .asciiz "\nRatio between total number of hours reserved for lectures and the total number of hours reserved OH = "
    newline: .asciiz "\n"
    dayExist: .asciiz "\nDay is exist\n"
    type : .asciiz "\nEnter the type of appointment:\n1: Lectures\n2: Office Hours \n3: Meetings \nYour choice: "
     noslot: .asciiz " no slot of time in this Range\n"
     OH: .asciiz "OH"
     M: .asciiz "M"
    L: .asciiz "L"
    space: .asciiz " "
    comma: .asciiz ","
    colon: ":"
    sign : "-" 
    day: .space 3
    startTime: .space 3
    end_Time: .space 3
     conflict: .asciiz "\nThere are a conflict withe this appointment : \n"
    true: .asciiz "trueeeeeeeeeee"
    acceptedslot: .asciiz "\nThere are no conflict with the appointments\n"
    deleteIgnored: .asciiz  "\nTry another Period\n"
    
#----------------------------------------------------  
################# Code segment #####################
#---------------------------------------------------

.text
.globl main
main: 
    li $v0, 16
    move $a0, $s0
    syscall

    # Print the menu
    li $v0, 4
    la $a0, menu_string
    syscall

    
    jal menu
    
    li $v0, 4
    la $a0, invaled
    syscall
    j main
    
 #-------------------------------------------------------
 ######################### MENU #########################   
 #-------------------------------------------------------
 openFile:
 
    li $v0, 16
    move $a0, $s0
    syscall

    # Open the file for reading
    li $v0, 13
    la $a0, filename
    li $a1, 0
    syscall
    move $s0, $v0
    jr $ra
    
 
 openFileToWrite:
     li $v0, 16
    move $a0, $s0
    syscall


    li $v0, 13
    la $a0, filename
    li $a1, 9
    syscall
    move $s0, $v0
    jr $ra
 openFileToWrite2:
  li $v0, 16
    move $a0, $s0
    syscall

    li $v0, 13
    la $a0, filename
    li $a1, 1
    syscall
    move $s0, $v0
    jr $ra
  
 menu: 

    # Read the user's input
    li $v0, 5
    syscall
    move $t1, $v0
    
    # Branch to the appropriate code based on the user's input
    beq $t1, 1, option_1
    beq $t1, 2, option_2
    beq $t1, 3, option_3
    beq $t1, 4, option_4
    beq $t1, 5, exit

    # Invalid input
    
    jr $ra
    
############### First option ############################
option_1:

    # Code for option 1
    li $v0, 4
    la $a0, menu_option_1
    syscall
    # Read the user's input
    li $v0, 5
    syscall
    move $t1, $v0
    beq $t1, 1, option_1_1
    beq $t1, 2, option_1_2
    beq $t1, 3, option_1_3
    li $v0, 4
    la $a0, invaled
    syscall
    j option_1
    
############################ read char by char from file ###################
 read_loop:

    li $v0, 14
    move $a0, $s0
    la $a1, buffer
    li $a2,1
    addiu $t4,$t4,1
    syscall
    jr $ra
 ########################## Write into file ############################
write_loop:

li $v0, 15
move $a0, $s0
la $a1, newline
li $a2, 1
syscall

li $v0, 15
move $a0, $s0
la $a1, day
jal checkIfmorethan9
syscall

li $v0, 15
la $a1, colon
 move $a0, $s0
li $a2, 1
syscall
    
li $v0, 15
move $a0, $s0
la $a1, space
li $a2, 1
syscall

li $v0, 15
move $a0, $s0
la $a1, startTime
move $t1,$t5
jal checkIfmorethan9
syscall


li $v0, 15
move $a0, $s0
la $a1, sign
li $a2, 1
syscall

li $v0, 15
move $a0, $s0
la $a1, end_Time
move $t1,$t6
jal checkIfmorethan9
syscall

li $v0, 15
move $a0, $s0
la $a1, space
li $a2, 1
syscall


beq $t4, 1, Le
beq $t4, 2, OHh
beq $t4, 3, Mm



Le: li $v0, 15
move $a0, $s0
la $a1, L
li $a2, 1
syscall


j main

OHh: li $v0, 15
move $a0, $s0
la $a1, OH
li $a2, 2
syscall

j main

Mm: li $v0, 15
move $a0, $s0
la $a1, M
li $a2, 1
syscall
j main

checkIfmorethan9:
ble $t1,9,digits
li $a2, 2
jr $ra
digits:
li $a2,1
jr $ra
#----------------------------------#
write_loop2:

subi $t7,$t7,1

li $v0, 15
move $a0, $s0
la $a1, buffer2
move $a2,$t7
syscall
li $v0, 15
la $a1,comma
 move $a0, $s0
li $a2, 1
syscall
li $v0, 15
move $a0, $s0
la $a1, space
li $a2, 1
syscall

li $v0, 15
move $a0, $s0
la $a1, startTime
move $t1,$t5
jal checkIfmorethan9
syscall

li $v0, 15
move $a0, $s0
la $a1, sign
li $a2, 1
syscall

li $v0, 15
move $a0, $s0
la $a1, end_Time
move $t1,$t6
jal checkIfmorethan9
syscall

li $v0, 15
move $a0, $s0
la $a1, space
li $a2, 1
syscall

beq $t0, 1, LECT
beq $t0, 2, Office
beq $t0, 3, MEETING



LECT: li $v0, 15
move $a0, $s0
la $a1, L
li $a2, 1
syscall


j endF

Office: li $v0, 15
move $a0, $s0
la $a1, OH
li $a2, 2
syscall

j endF

MEETING: li $v0, 15
move $a0, $s0
la $a1, M
li $a2, 1
syscall
endF:

li $v0, 15
move $a0, $s0
la $a1, newline
li $a2, 1
syscall
subi $t2,$t2,1
li $v0, 15
move $a0, $s0
la $a1, buffer3
move $a2,$t2
syscall
j main
 ##########################  check Start Time And End Time ######################
 
 checkStartTimeAndEndTime:
  #Read the start time for the slot 
again:   la $a0,starttime
         li $v0,4
         syscall
         li $v0,5
         syscall
         move $t5,$v0
         #the numbers from 1-5 will be 13-17      1 2 3 4 5 
    #check for numbers between 1-7 if the sum +12 greater than  17 then its ignored 
    
    ble $t5,7,L2
    j next
  L2:  addiu $t5,$t5,12
       bgt $t5,17,warning
       j next
warning:   la $a0,errorslot
           li $v0,4
           syscall
           j again
           
  #Read the end time for the slot 
next: la $a0,endtime
      li $v0,4
      syscall
      li $v0,5
      syscall
      move $t6,$v0
#check for the Range 8AM-5PM

    ble $t6,7,L4
    j c
L4:  addiu $t6,$t6,12
     bgt $t6,17,warning2
     j c
     #cheeck if befor the start time

warning2:     
          la $a0,errorslot
           li $v0,4
           syscall
           j next
warning3:
     la $a0,error2slot
           li $v0,4
           syscall
           j next
 c:     ble $t6,$t5,warning3
 jr $ra

    
############### view the calendar per day ##############   
############# t9 --- > day number after convert to int from file  
option_1_1:
    jal openFile
    
    li $v0, 4
    la $a0, per_day
    syscall
    
    
    # Read the user's input
    li $v0, 5
    syscall
    move $t1, $v0
    
   
     li $v0, 1
     move $a0,$t1
     syscall
    
    
    li $t9, 0 #to convert the number of day to integer
    move $t4,$zero
    
    jal read_loop
    beq $v0, 0,ThisdayDoesNotExist
    ble $t4,2,str2int
   

    cont:   
              
    	     lb $t0, buffer       # load the read character  
             beq $t0, '\n' ,continue
             beq $t9,$t1,process_line
             j read_loop
       
       
    continue:
    		bne $t8,0,contOption2
        	beq $t9,$t1,main 
        return:	li $t9, 0
    		move $t4,$zero
    		j read_loop
    	
    str2int:
    		lb $t3, buffer       
    		beq $t3,':',cont
    		#addiu $t3, $t3, -48
    		subi $t3 , $t3 ,48
   		 mul $t9, $t9, 10 # t9 --> 0  1 * 10 -->10 
    		addu $t9, $t9, $t3 # 0 + 1  //t9 ? 1 ?? int
    		j read_loop
   
    process_line:
       		li $v0, 4
       		la $a0,buffer
       		syscall
       		j read_loop
       
    ThisdayDoesNotExist:
    	        beq $t9,$t1,main
        	li $v0, 4
        	la $a0, message_dayDoesNotExist
        	syscall
        	li $v0, 16
        	move $a0, $s0
        	syscall
        	j option_1_1

############### view the calendar per set of days ##############  	
option_1_2:

    li $v0, 4
    la $a0, per_set_of_days
    syscall

    
    # Read the user's input
     li $v0, 5
     syscall
     move $t8, $v0
     bgtz $t8,option_1_1
     contOption2:  beq $t9,$t1,minus
                   j return
                   
     minus: sub $t8,$t8,1
            bne $t8,0,option_1_1
            j main
     

option_1_3:
###################### t1 --> number of day / t5 --> start time / t6--> end time
     jal openFile
    
    li $v0, 4
    la $a0, per_day
    syscall
    
    # Read the user's input
    li $v0, 5
    syscall
    move $t1, $v0
    
    #Read the start time for the slot 
       jal checkStartTimeAndEndTime
complete:  
    move $t4,$zero
    move $t9,$zero
    move $t8,$zero
    move $t2,$zero
    jal read_loop
    ble $t4,2,strtoint
    move $t3,$v0
    beqz $v0,ThisdayDoesNotExis #the end of the file #we get the end of the slot in $t8 in the last line in the file
    
    #load the first char from the buffer to $t0
s:    lb $t0, buffer 
      beq $t0,'\n',continu
      beq $t1,$t9,ok
      j read_loop

continu: 
        beq  $t1,$t9,process #here we reach the  end of the line and we need the value of $t8 
        move $t4,$zero 
        move $t9,$zero
           j read_loop
         
ok:    #process-line 
      lb $a0,buffer
      #if the number not digit we not call string too int function
      blt $a0,48,notdigit  
      bgt $a0,57,notdigit
      #the counter will count the number of digits char only 
      add $t2,$t2,1
      ble $t2,2,strtooint

notdigit: 
      beq $a0,'O',printtypee
      beq $a0,'M',printtype
      beq $a0,'L',printtype
      j checkdigitComplete   
printtype:
          li $v0,11
          syscall    
          la $a0,' '
          syscall
          j checkdigitComplete         
printtypee:      
      la $a0,OH
      li $v0,4
      syscall
      la $a0,' '
      li $v0,11
      syscall
           
checkdigitComplete:   
      beq $a0,',',process      #we get the end of the slot in $t8
      beq $a0,'-',starttimestore     #we get the start of the slot in $t8
      j read_loop
      
starttimestore:   
      bge $t8,1,L5  #(1<=input<=7)
        j end
L5: ble $t8,7,L6
    j end
L6:  addiu $t8,$t8,12
        
end: 
          move $t7,$t8   #the start time
          move $t8,$zero
          move $t2,$zero
          j read_loop
        #in this label compare operation will be done   
process: #start time in $t7 , end time in $t8   (From the file)
        bge $t8,1,L7  #(1<=input<=7)
        j startt
L7: ble $t8,7,L8
    j startt
L8:  addiu $t8,$t8,12 

startt:
      ble $t8,$t5,NoPeriod      #end time < st of entered period
      bge $t7,$t6,NoPeriod      #start time > et of entered period
      bge $t7,$t5,checkIfInRange
      blt $t7,$t5,StartTimeIsLess
      
StartTimeIsLess: 
      ble $t8,$t6,EndTimeIsLessThanEntered
      #start timee less than entered and the end time greater than entered so change both
      move $t7,$t5
      move $t8,$t6
      j endd
#we change the Value of starttime to be the entered value
EndTimeIsLessThanEntered:
        move $t7,$t5
        j endd           
checkIfInRange: 
         ble $t8,$t6,inRange
         #End time is Greater than the entered so change it
         move $t8,$t6
         j endd
    
inRange:  
          j endd   #print them as they are
                
NoPeriod: #print the warning
          la $a0,noslot
          li $v0,4
          syscall 
          j did

endd:     #print the start time
         li $v0,1
          move $a0,$t7
          syscall 
          li $v0,11
          la $a0,'-'
          syscall
          #print the end time
          li $v0,1
          move $a0,$t8
          syscall
          la $a0,newline
          li $v0,4
          syscall
      #to do this each eteration
did:      move $t8,$zero
          move $t2,$zero
          move $t7,$zero
          beq $t0,'\n',main
          beqz $t3,main
          j read_loop
          
strtoint:
   lb $t3, buffer       #the character 
   beq $t3,':',s   #for two digits number check
   addiu $t3, $t3, -48
   mul $t9, $t9, 10 # t9 --> 0  1 * 10 -->10 
   addu $t9, $t9, $t3 # 0 + 1  //t9 ? 1 ?? int  
   j read_loop 
strtooint:
      lb $t3,buffer
      addiu $t3, $t3, -48
      mul $t8, $t8, 10 # t9 --> 0  1 * 10 -->10 
      addu $t8, $t8, $t3 # 0 + 1  //t9 ? 1 ?? int  
      j read_loop
 ThisdayDoesNotExis:
      beq $t9,$t1,process
      li $v0, 4
      la $a0, message_dayDoesNotExist
      syscall
      li $v0, 16
      move $a0, $s0
      syscall
      j option_1_3	    

  

############### View Statistics ############## 
option_2:
     jal openFile
	
	move $t2,$zero # to put number of lectures (in hours) 
	move $t5,$zero # to put number of OH
	move $t6,$zero # to put number of meetings
	move $t4,$zero # to count if we pass first 3 char from any line in the file ( number of day and  ( : ) ) 
	move $t9,$zero 
	move $t8,$zero # to count the number of lines (days ) in the file (option 4)
	jal read_loop
	
    beq $v0, 0,endFile
    ble $t4,3,read_loop 
    
    cont1:    
    	     lb $t0, buffer       # load the read character 
    	     beq $t0,'\n',newlinee
    	     blt $t0, 48, notDigit  # if character is less than '0', not a digit
             bgt $t0, 57 , notDigit  # if character is greater than '9', not a digit
             j convertToInt
             
     newlinee:
     add $t8,$t8,1 # num of lines 
     move $t4,$zero 
     move $t9,$zero
     j read_loop
     
     notDigit:
          
          beq $t0,'-',endTime
          beq $t0,',',read_loop
          beq $t0,' ',read_loop
          beq $t0,'H',read_loop
          beq $t0,'\r',read_loop # \r -- > char before the \n
          j Statistics # if the char = [ L OR O OR M ]
          
          
    Statistics:
    
    ble $t1,5,add12Start
  don1e:  ble $t9,5,add12end
  don2e: sub $t3,$t9,$t1
         move $t9,$zero
   	  beq $t0,'L',lectures
          beq $t0,'O',Office_Hours
          beq $t0,'M',Meetings
   add12Start:
   add $t1,$t1,12
   j don1e
   add12end:
   add $t9,$t9,12
   j don2e
   
   lectures: # to calculate the number of  lectures
     add $t2,$t2,$t3
     j read_loop
   Office_Hours: # to calculate the number of  OH
    add $t5,$t5,$t3
     j read_loop
   Meetings: #to calculate the number of  Meetings
    add $t6,$t6,$t3
     j read_loop
   
     endTime:
      		move $t1,$t9
      		move $t9,$zero
      		j read_loop
      		
     convertToInt:
    		lb $t3, buffer       
    		addiu $t3, $t3, -48
   		 mul $t9, $t9, 10 # t9 --> 0  1 * 10 -->10 
    		addu $t9, $t9, $t3 # 0 + 1  //t9 ? 1 ?? int
    		j read_loop
     
    endFile:
        	li $v0, 16
        	move $a0, $s0
        	syscall
        	
   
    li $v0, 4
    la $a0, menu_option_2
    syscall
    
     # Read the user's input
    li $v0, 5
    syscall
    move $t1, $v0
    
    beq $t1, 1, option_2_1
    beq $t1, 2, option_2_2
    beq $t1, 3, option_2_3
    beq $t1, 4,option_2_4
    beq $t1, 5,option_2_5
    
    j option_2 # if the user's input invaled input --> more the 5 or minus option or etc...
    
############# View Statistics: number of lectures (in hours) ##################     	
option_2_1: 
 	
 	# number of lectures
                li $v0,4
                la $a0,numOfLec
                syscall
                 li $v0, 1
        	move $a0, $t2
        	syscall
        	li $v0,4
               la $a0,newline 
                syscall
                j main
               
               
option_2_2:
	# number of OH
                li $v0,4
                la $a0,numOfOH
                syscall
                li $v0, 1
        	move $a0, $t5
        	syscall
        	li $v0,4
               la $a0,newline
               syscall
               j main
option_2_3:
    ### number of Meetings
               li $v0,4
                la $a0, numOfM
                syscall
                li $v0, 1
        	move $a0, $t6
        	syscall
        	li $v0,4
               la $a0,newline
                syscall
        	j main
option_2_4:

	li $v0,4
        la $a0, avglectures
        syscall
        add $t8,$t8,1
        mtc1 $t2, $f0 # to convert the integer into float number
        mtc1 $t8,$f1 
        div.s $f0,$f0,$f1
        
        # Print the result
        li $v0, 2               # system call for print float
        mov.s $f12,$f0         # result
        syscall
        j main
        
 option_2_5:
 	li $v0,4
        la $a0, ratio
        syscall
 	mtc1 $t2, $f0
        mtc1 $t5,$f1 
        div.s $f0,$f0,$f1
	# Print the result
        li $v0, 2               # system call for print float
        mov.s $f12,$f0         # result
        syscall
        j main
        
option_3:
# t1 --> number of day / t5 --> start time / t6--> end time /  t4 --> type
  
    li $v0, 4
    la $a0, per_day
    syscall
    
    # Read the user's input
    li $v0, 5
    syscall
    move $t1, $v0
   day_existTRY:  jal openFile
    move $t7,$zero
    li $t9, 0 #to convert the number of day to integer
    move $t4,$zero
 complette:  
    jal read_loop
    addi $t7,$t7,1
    beq $v0, 0,FreeDay
    ble $t4,2,str2int2 
    cont11:
    	     lb $t0, buffer       # load the read character  
             beq $t0, '\n' ,continue1
             beq $t9,$t1,day_exist
             j read_loop
    continue1:
        	beq $t9,$t1,day_exist
            	li $t9, 0
    		move $t4,$zero
    		j read_loop
    day_exist:
    		 li $sp, 0x7FFFFFFC  # Example initial value for the stack pointer
		li $t0, 42
   		 sw $t7, 0($sp)     # Push $t0 onto the stack
   		 sub $sp, $sp, 4     # Adjust the stack pointer
   		 
        	jal checkStartTimeAndEndTime # t5 --> start // t6 --> end 
        	li $v0, 4
        	la $a0, type
        	syscall
        	li $v0, 5
                syscall 
                move $t0, $v0 # t4 -->type 
                jal optionn_3	
               
    		
     
     
     #checkkk ----
   str2int2:
    		lb $t3, buffer       
    		beq $t3,':',cont11
    		addiu $t3, $t3, -48
   		 mul $t9, $t9, 10 # t9 --> 0  1 * 10 -->10 
    		addu $t9, $t9, $t3 # 0 + 1  //t9 ? 1 ?? int
    		j read_loop
        
   FreeDay:
        	li $v0, 4
        	la $a0, message_dayDoesNotExist
        	syscall
        	
        	jal checkStartTimeAndEndTime # t5 --> start // t6 --> end 
        	li $v0, 4
        	la $a0, type
        	syscall
        	li $v0, 5
                syscall 
                move $t4, $v0 # t4 -->type 
                #-------- to put the lines in the file into buffer-------------
                
    		jal minus12
    		move $a0,$t1
    		jal convertIntToString
    		    		move $a0,$t5
    		jal  convertIntToStrings
    		    		move $a0,$t6
    		jal   convertIntToStringe
    		#-------------open file to write-------------------
    		jal openFileToWrite
    		jal write_loop
  		
convertIntToString:
        # Function to convert integer to string
        li $v0, 0          # Initialize loop counter
        li $t7, 10         # Set divisor (for decimal representation)
    convert_loop1:
        divu $a0, $t7      # Divide integer by 10      11/10   1
        mflo $t3           # Quotient (next iteration value)1
        mfhi $a0          # Remainder (current digit)   23  1
        # Add 48 to convert the digit to ASCII and store in output_buffer
        beqz $t3,convertSingle
    addi $t3, $t3, 48  # Add 48 to convert to ASCII
        sb $t3, day($v0)  # Store digit in output_buffer
        addi $v0, $v0, 1   # Move to the next position in output_buffer
       convertSingle:
        addi $a0, $a0, 48  # Add 48 to convert to ASCII
        sb $a0, day($v0)  # Store digit in output_buffer
        addi $v0, $v0, 1   # Move to the next position in output_buffer
        sb $zero, day($v0)
        jr $ra
        
 convertIntToStrings:
        # Function to convert integer to string
        li $v0, 0          # Initialize loop counter
        li $t7, 10         # Set divisor (for decimal representation)
    convert_loop11:
        divu $a0, $t7      # Divide integer by 10      11/10   1
        mflo $t3           # Quotient (next iteration value)1
        mfhi $a0          # Remainder (current digit)   23  1
        # Add 48 to convert the digit to ASCII and store in output_buffer
        beqz $t3,convertSingle1
        addi $t3, $t3, 48  # Add 48 to convert to ASCII
        sb $t3, startTime($v0)  # Store digit in output_buffer
        addi $v0, $v0, 1   # Move to the next position in output_buffer
         convertSingle1:
        addi $a0, $a0, 48  # Add 48 to convert to ASCII
        sb $a0, startTime($v0)  # Store digit in output_buffer
        addi $v0, $v0, 1   # Move to the next position in output_buffer
        sb $zero,startTime($v0)
        jr $ra
 convertIntToStringe:
        # Function to convert integer to string
        li $v0, 0          # Initialize loop counter
        li $t7, 10         # Set divisor (for decimal representation)
    convert_loo:
        divu $a0, $t7      # Divide integer by 10      11/10   1
        mflo $t3           # Quotient (next iteration value)1
        mfhi $a0          # Remainder (current digit)   23  1
        # Add 48 to convert the digit to ASCII and store in output_buffer
        beqz $t3,convertSingle2
        addi $t3, $t3, 48  # Add 48 to convert to ASCII
        sb $t3, end_Time($v0)  # Store digit in output_buffer
        addi $v0, $v0, 1   # Move to the next position in output_buffer
       convertSingle2:
        addi $a0, $a0, 48  # Add 48 to convert to ASCII
        sb $a0, end_Time($v0)  # Store digit in output_buffer
        addi $v0, $v0, 1   # Move to the next position in output_buffer
        sb $zero,end_Time($v0)
        jr $ra
   minus12:
  		ble $t5,12,contin
  		sub $t5,$t5,12
  	contin:ble $t6,12,m222
  		sub $t6,$t6,12
  		m222:
  		jr $ra
  		
  	
#############################################################
########################################################333
optionn_3:       #t0 has the type  
    move $t2,$zero
    move $t8,$zero
    jal read_loop
    move $t3,$v0
    beqz $v0,ThisdayDoesNotExiis #the end of the file #we get the end of the slot in $t8 in the last line in the file
    
ss:   lb $a0, buffer 
      beq $a0,'\n',continuu
      beq $t1,$t9,okk
       j read_loop

continuu: 
       beq  $t1,$t9,processs #here we reach the  end of the line and we need the value of $t8 
       move $t9,$zero
       j read_loop
         
okk:    #process-line 
      lb $a0,buffer
      blt $a0,48,notdigitt  
      bgt $a0,57,notdigitt
      #the counter will count the number of digits char only 
      add $t2,$t2,1
      ble $t2,2,strtoointt

notdigitt: 
      beq $a0,'O',load
      beq $a0,'M',load
      beq $a0,'L',load
      j checkdigitCompplete

load:   lb $t2,buffer
 
checkdigitCompplete:   
      beq $a0,',',processs      #we get the end of the slot in $t8
      beq $a0,'-',starttimestoree     #we get the start of the slot in $t8
      j read_loop
      
starttimestoree:   
      bge $t8,1,LL5  #(1<=input<=7)
        j ennd
LL5: ble $t8,7,LL6
    j ennd
LL6:  addiu $t8,$t8,12
        
ennd: 
          move $t7,$t8   #the start time
          move $t8,$zero
          move $t2,$zero
          j read_loop
        #in this label compare operation will be done   
processs: #start time in $t7 , end time in $t8   (From the file)
        bge $t8,1,LL7  #(1<=input<=7)
        j staartt
LL7: ble $t8,7,LL8
    j staartt
LL8:  addiu $t8,$t8,12 
 
#it the entered is the same exactly of one of them
staartt:
     bgt $t6,$t7,rr
     j k
rr:
     blt $t6,$t8,conflictt #The end time In the Range Only
          
k:        beq $t5,$t7,equal
          j check2
          
equal:
           beq $t6,$t8,conflictt   #equals the start and the end (The same period)
           blt $t6,$t8,conflictt #equal start but not the end  (In The Range)
           j conflictt    #equal the start time and greater end Time
check2:  #If the start not Equals
         bgt $t5,$t7,InRange   #check if in the Range
         j enddf   #No Problem
         
InRange:
         blt $t6,$t8,conflictt  #the slot in The Range
         beq $t6,$t8,conflictt   #Greater then Starttime and Equal the End 
         j enddf    #Greater then the start and greater then the end (not in the Range)
#If The end time only in the Range             
conflictt:
     #print the start time
          la $a0,conflict
          li $v0,4
          syscall
          li $v0,1
          move $a0,$t7
          syscall 
          li $v0,11
          la $a0,'-'
          syscall
          #print the end time
          li $v0,1
          move $a0,$t8
          syscall
      #print the type
      move $a0,$t2
      beq $t2,'O',printtyppee
      beq $t2,'M',printtyppe
      beq $t2,'L',printtyppe
 
printtyppe:
          li $v0,11
          syscall    
          la $a0,' '
          syscall
   j day_existTRY        
printtyppee:
      la $a0,OH      
      li $v0,4
      syscall
      la $a0,' '
      li $v0,11
      syscall
     j day_existTRY
          
enddf:    
          move $t8,$zero
          move $t2,$zero
          move $t7,$zero
          lb $a0,buffer
          beq $a0,'\n',printNewSlot
          beqz $t3,printNewSlot
           j  read_loop

printNewSlot:
   jal target
printNewSlott:
    beq $t0, 1, Lec
    beq $t0, 2, OHH
    beq $t0, 3, MM
    j nnext
Lec:  la $a0,L
      j nnext
OHH:   la $a0,OH
      j nnext
MM:    la $a0,M
nnext:
	
 
    jal minus12
     		   		move $a0,$t5
    		jal  convertIntToStrings
    		    		move $a0,$t6
    		jal   convertIntToStringe
    		#----------------------
    		 add $sp, $sp, 4     # Adjust the stack pointer
   		 lw $t7, 0($sp)     # Pop a value from the stack
    		jal openFile
    		li $v0, 14
   		 move $a0, $s0
  		  la $a1, buffer2
    		move $a2,$t7
   		 syscall
   	     move $t2,$zero
   	co12nttt: jal read_loop 
   		addi $t7,$t7,1
   		lb $t4, buffer       # load the read character
   		beqz $v0,lastLine  
              bne $t4, '\n' ,co12nttt
              
              #move $t2,$zero
       co123nttt: jal read_loop
       		addi $t2,$t2,1
       		bnez $v0,co123nttt
       		
           jal openFile
    		li $v0, 14
   		 move $a0, $s0
  		  la $a1, buffer2
    		move $a2,$t7
   		 syscall
    		li $v0, 14
   		 move $a0, $s0
  		  la $a1, buffer3
    		move $a2,$t2
   		 syscall
    		jal openFileToWrite2
		j write_loop2
		
  #-------------open file to write-------------------
    
strtointt:
   lb $t3, buffer       #the character 
   beq $t3,':',s   #for two digits number check
   addiu $t3, $t3, -48
   mul $t9, $t9, 10 # t9 --> 0  1 * 10 -->10 
   addu $t9, $t9, $t3 # 0 + 1  //t9 ? 1 ?? int  
   j read_loop 
strtoointt:
      lb $t3,buffer
      addiu $t3, $t3, -48
      mul $t8, $t8, 10 # t9 --> 0  1 * 10 -->10 
      addu $t8, $t8, $t3 # 0 + 1  //t9 ? 1 ?? int  
      j read_loop
 ThisdayDoesNotExiis:
      beq $t9,$t1,processs
      j optionn_3
 
target:
                 move $t8,$zero
                 move $t2,$zero
    		 add $sp, $sp, 4     # Adjust the stack pointer
   		 lw $t7, 0($sp)     # Pop a value from the stack
   		 li $sp, 0x7FFFFFFC  # Example initial value for the stack pointer
   		 sw $t7, 0($sp)     # Push $t0 onto the stack
   		 sub $sp, $sp, 4     # Adjust the stack pointer
                 jal openFile         
                li $v0, 14
   		move $a0, $s0
  		 la $a1, buffer2
    		 move $a2,$t7
    		 la $a0,newline
    		 li $v0,4
    		 syscall

Complete:  
    move $t4,$zero
    move $t9,$zero
    move $t8,$zero
    move $t2,$zero
    jal read_loop
    ble $t4,2,Strtoint
    move $t3,$v0
    beqz $v0,thisdayDoesNotExis #the end of the file #we get the end of the slot in $t8 in the last line in the file
    
    #load the first char from the buffer to $t0
S:    lb $a0, buffer 
      beq $a0,'\n',Continu
      beq $t1,$t9,Ok
      j read_loop

Continu: 
        beq  $t1,$t9,Process #here we reach the  end of the line and we need the value of $t8 
        move $t4,$zero 
        move $t9,$zero
           j read_loop
         
Ok:    #process-line 
      lb $a0,buffer
      #if the number not digit we not call string too int function
      blt $a0,48,Notdigit  
      bgt $a0,57,Notdigit
      #the counter will count the number of digits char only 
      add $t2,$t2,1
      ble $t2,2,Strtooint

Notdigit:    
 
      addiu $t7,$t7,1
     beq $a0,'-',Starttimestore     #we get the start of the slot in $t8
      beq $a0,',',Process      #we get the end of the slot in $t8
      j read_loop
      
Starttimestore:   
      bge $t8,1,LI5  #(1<=input<=7)
        j End
LI5: ble $t8,7,LI6
    j End
LI6:  addiu $t8,$t8,12
        
End:  
    #here we compare $t6 with the start time in the file
           ble $t6,$t8,FindedLocation
           j else
FindedLocation:           #stop the counter from count 
         subi $t7,$t7,3 #remove - and space and ,
          sub $t7,$t7,$t2 #the number of digits in target start
         move $t2,$zero # to count # of char after the apointment
           jal openFile
                 
            li $v0, 14
   		move $a0, $s0
  		 la $a1, buffer2
    		 move $a2,$t7
                 syscall
        countNumOfcharAfterTheApoin: jal read_loop
       		addi $t2,$t2,1
       		bnez $v0,countNumOfcharAfterTheApoin
       		
       		jal openFile
                li $v0, 14
   		move $a0, $s0
  		 la $a1, buffer3
    		 move $a2,$t7
                 syscall
                 move $t4,$t7
                 li $v0, 14
   		move $a0, $s0
  		 la $a1, buffer4
    		 move $a2,$t2
                 syscall
          	j write
else:    #complete the count 
          move $t8,$zero
          move $t2,$zero
          j read_loop
        #in this label compare operation will be done   
Process: #start time in $t7 , end time in $t8   (From the file)
      #to do this each eteration
          move $t8,$zero
          move $t2,$zero
         lb $a0,buffer
         beq $a0,'\n',printNewSlott
         beqz $t3,printNewSlott
          j read_loop
          
Strtoint:
   lb $t3, buffer       #the character 
   beq $t3,':',S   #for two digits number check
   addiu $t3, $t3, -48
   mul $t9, $t9, 10 # t9 --> 0  1 * 10 -->10 
   addu $t9, $t9, $t3 # 0 + 1  //t9 ? 1 ?? int  
   j read_loop 
Strtooint:
      lb $t3,buffer
      addiu $t3, $t3, -48
      mul $t8, $t8, 10 # t9 --> 0  1 * 10 -->10 
      addu $t8, $t8, $t3 # 0 + 1  //t9 ? 1 ?? int  
      addiu $t7,$t7,1
      j read_loop
thisdayDoesNotExis:
      beq $t9,$t1,Process
      li $v0, 4
      la $a0, message_dayDoesNotExist
      syscall
      li $v0, 16
      move $a0, $s0
      syscall
      j main
write:
      jal minus12
     		   		move $a0,$t5
    		jal  convertIntToStrings
    		    		move $a0,$t6
    		jal   convertIntToStringe
    		jal openFileToWrite2
    li $v0, 15
move $a0, $s0
la $a1, buffer3
move $a2,$t4
syscall
 
li $v0, 15
move $a0, $s0
la $a1, space
li $a2, 1
syscall

li $v0, 15
move $a0, $s0
la $a1, startTime
move $t1,$t5
jal checkIfmorethan9
syscall

li $v0, 15
move $a0, $s0
la $a1, sign
li $a2, 1
syscall

li $v0, 15
move $a0, $s0
la $a1, end_Time
move $t1,$t6
jal checkIfmorethan9
syscall
 
li $v0, 15
move $a0, $s0
la $a1, space
li $a2, 1
syscall

beq $t0, 1, LECTu
beq $t0, 2, Officeh
beq $t0, 3, MEETINGs
LECTu: li $v0, 15
move $a0, $s0
la $a1, L
li $a2, 1
syscall
j endFFF

Officeh: li $v0, 15
move $a0, $s0
la $a1, OH
li $a2, 2
syscall

j endFFF

MEETINGs: li $v0, 15
move $a0, $s0
la $a1, M
li $a2, 1
syscall
endFFF:
li $v0, 15
la $a1,comma
 move $a0, $s0
li $a2, 1
syscall
sub $t2,$t2,1
li $v0, 15
move $a0, $s0
la $a1, buffer4
move $a2,$t2
syscall
      j main
      
 lastLine:
             jal openFile
    		li $v0, 14
   		 move $a0, $s0
  		  la $a1, buffer3
    		move $a2,$t7
   		 syscall
   		 subi $t7,$t7,1
    		jal openFileToWrite2
    		    	
li $v0, 15
move $a0, $s0
la $a1, buffer3
move $a2,$t7
syscall
  li $v0, 15
la $a1,comma
 move $a0, $s0
li $a2, 1
syscall
li $v0, 15
move $a0, $s0
la $a1, space
li $a2, 1
syscall

li $v0, 15
move $a0, $s0
la $a1, startTime
move $t1,$t5
jal checkIfmorethan9
syscall

li $v0, 15
move $a0, $s0
la $a1, sign
li $a2, 1
syscall

li $v0, 15
move $a0, $s0
la $a1, end_Time
move $t1,$t6
jal checkIfmorethan9
syscall
 
li $v0, 15
move $a0, $s0
la $a1, space
li $a2, 1
syscall

beq $t0, 1, LECTu2
beq $t0, 2, Officeh2
beq $t0, 3, MEETINGs2
LECTu2: li $v0, 15
move $a0, $s0
la $a1, L
li $a2, 1
syscall
j main

Officeh2: li $v0, 15
move $a0, $s0
la $a1, OH
li $a2, 2
syscall

j main

MEETINGs2: li $v0, 15
move $a0, $s0
la $a1, M
li $a2, 1
syscall
j main


#######------------------------------Option 4 -----------------------------------##############		 
option_4:
    # Code for option 4
Ignore:   #If the delted Period not  acceptable will Restart from here.
    li $v0, 4
    la $a0, per_day
    syscall
    
    # Read the user's input
    li $v0, 5
    syscall
    move $t1, $v0
    jal checkStartTimeAndEndTime # t5 --> start // t6 --> end 
    li $v0, 4
    la $a0, type
       syscall
    li $v0, 5
      syscall 
    move $t0, $v0 # t0 -->type 
   jal openFile
ccomplete:  
    move $t4,$zero
    move $t9,$zero
    move $t8,$zero
    move $t2,$zero
    jal read_loop
    ble $t4,2,SStrtoint
    beqz $v0,tthisdayDoesNotExis #the end of the file #we get the end of the slot in $t8 in the last line in the file
    
    #load the first char from the buffer to $t0
SS:    lb $a0, buffer 
      beq $a0,'\n',CContinu
      beq $t1,$t9,OOk
      j read_loop

CContinu: 
        beq  $t1,$t9,PProcess #here we reach the  end of the line and we need the value of $t8 
        move $t4,$zero 
        move $t9,$zero
           j read_loop
         
OOk:    #process-line 
      lb $a0,buffer
      #if the number not digit we not call string too int function
      blt $a0,48,NNotdigit  
      bgt $a0,57,NNotdigit
      #the counter will count the number of digits char only 
      add $t2,$t2,1
      ble $t2,2,SStrtooint

NNotdigit:    
     beq $a0,'L',storee
     beq $a0,'O',storee
     beq $a0,'M',storee
     j neext
 
storee:
      move $t3,$a0   
              
neext:     
      beq $a0,',',PProcess            #we get the end of the slot in $t8
      beq $a0,'-',SStarttimestore     #we get the start of the slot in $t7
      j read_loop
      
SStarttimestore:   
        bge $t8,1,checkIfGreaterthanOne  #(1<=input<=7)
        j StoreTheStartTime
checkIfGreaterthanOne:
          ble $t8,7,checkIfLessthanSeven
           j StoreTheStartTime
checkIfLessthanSeven:  
        addiu $t8,$t8,12
        
StoreTheStartTime: 
          move $t7,$t8   #the start time
          move $t8,$zero
          move $t2,$zero
          j read_loop
        #in this label compare operation will be done   
PProcess: #start time in $t7 , end time in $t8   (From the file)
        move $a0,$t3   # the character in File Such as'M','L','O' only .
        
beq $t0,1,checkIf1
beq $t0,2,checkIf2
beq $t0,3,checkIf3
checkIf1: 
    beq $a0,'L',DO
    j Con
     
checkIf2:
   beq $a0,'O',DO
   j Con

checkIf3:
       beq $a0,'M',DO
       j Con
    
DO:    
        bge $t8,1,checkIfGreaterThan1  #(1<=input<=7)
        j Startt
checkIfGreaterThan1: 
       ble $t8,7,checkIfLessThan7
        j Startt
checkIfLessThan7: 
            addiu $t8,$t8,12 

Startt:
        #if it equal a period the same the or in This Range it will be deleted
        bge $t7,$t5,Ch2
        j Con
        
Ch2:
       ble $t8,$t6,deleteThisPeriod   #the counter will Stop count 
       j Con
               
deleteThisPeriod:
       #print the start time
          move $t5,$t7 #start in the file
          j CounterForChar
      #to do this each eteration
Con:      move $t8,$zero
          move $t2,$zero
          move $t7,$zero
          lb $a0,buffer
          beq $a0,'\n',Ignored         
          lb $v0,buffer
          beqz $v0,main
          j read_loop
Ignored:
      la $a0,deleteIgnored 
      li $v0,4
      syscall
      j Ignore



SStrtoint:
   lb $t3, buffer       #the character 
   beq $t3,':',SS   #for two digits number check
   addiu $t3, $t3, -48
   mul $t9, $t9, 10 # t9 --> 0  1 * 10 -->10 
   addu $t9, $t9, $t3 # 0 + 1  //t9 ? 1 ?? int  
   j read_loop 
SStrtooint:
      lb $t3,buffer
      addiu $t3, $t3, -48
      mul $t8, $t8, 10 # t9 --> 0  1 * 10 -->10 
      addu $t8, $t8, $t3 # 0 + 1  //t9 ? 1 ?? int  
      j read_loop
tthisdayDoesNotExis:
      beq $t9,$t1,PProcess
      li $v0, 4
      la $a0, message_dayDoesNotExist
      syscall
      li $v0, 16
      move $a0, $s0
      syscall
      j main
    
    #t0 Is empty
CounterForChar:
    jal openFile  
Restart:  
    move $t4,$zero
    move $t9,$zero
    move $t8,$zero
    move $t0,$zero
    move $t2,$zero
    move $t7,$zero
    jal read_loop
    ble $t4,2,Strrtoint
    move $t3,$v0
    beqz $v0,thiisdayDoesNotExis #the end of the file #we get the end of the slot in $t8 in the last line in the file
    
    #load the first char from the buffer to $t0
LoadFromBuffer:    
      lb $a0, buffer 
      beq $a0,'\n',Conntinu
      beq $t1,$t9,Okey
      addiu $t7,$t7,1
      j read_loop

Conntinu: 
        beq  $t1,$t9,Proocess #here we reach the  end of the line and we need the value of $t8 
        addiu $t7,$t7,1
        move $t4,$zero 
        move $t9,$zero
           j read_loop
         
Okey:    #process-line 
      lb $a0,buffer
      #if the number not digit we not call string too int function
      blt $a0,48,Nottdigit  
      bgt $a0,57,Nottdigit
      #the counter will count the number of digits char only 
      add $t2,$t2,1
      ble $t2,2,Strrtooint

Nottdigit:    
     addiu $t7,$t7,1
     beq $a0,'-',Staarttimestore     #we get the start of the slot in $t8
      beq $a0,',',Proocess      #we get the end of the slot in $t8
      j read_loop
      
Staarttimestore:   
      bge $t8,1,checkGreaterThan1  #(1<=input<=7)
        j Ennd
checkGreaterThan1:
    ble $t8,7,checkLessThan7
    j Ennd
checkLessThan7:  
        addiu $t8,$t8,12
        
Ennd:  
    #here we compare $t6 with the start time in the file
           beq $t5,$t8,FinndedLocation
           j elsse
FinndedLocation:           #stop the counter from count 
         subi $t7,$t7,3 #remove - and space and ,
          sub $t7,$t7,$t2 #the number of digits in target start
          la $a0,newline
          li $v0,4
          syscall
          move $t2,$zero # to count # of char after the apointment
          move $t0,$zero
          jal openFile
          li $v0, 14
   		 move $a0, $s0
  		  la $a1, buffer2
    		move $a2,$t7
   		 syscall
   		
   toCountCharToRemove:
   		 jal read_loop
   		 lb $a0,buffer
   		 add $t2,$t2,1
   		 beq $a0,':',FirstappoinWillRemove
   		 beq $a0,'M',StopCounter
   		 beq $a0,'O',TheappointOH
   		 beq $a0,'L',StopCounter
   		 j toCountCharToRemove
   		 
   		
  FirstappoinWillRemove:
  addi $t7,$t7,1
   j toCountCharToRemove
  TheappointOH:
  addi $t2,$t2,1	 
StopCounter:      
                  jal read_loop
                  addiu $t0,$t0,1
                  bnez $v0,StopCounter
                  subi $t0,$t0,1
#-------------------------To Write the Data After remove in file--------- t7--> first buffer2 -------- t0 --->second buffer3
                  jal openFile
                  li $v0, 14
   		 move $a0, $s0
  		  la $a1, buffer2
    		move $a2,$t7
   		 syscall  
                  li $v0, 14
   		 move $a0, $s0
  		  la $a1, remove
    		move $a2,$t2
   		 syscall
   		 li $v0, 14
   		 move $a0, $s0
  		  la $a1, buffer3
    		move $a2,$t0
   		 syscall
   		 j writeAfterRemove
         
elsse:    #complete the count 
          move $t8,$zero
          move $t2,$zero
          j read_loop
        #in this label compare operation will be done   
Proocess: #start time in $t7 , end time in $t8   (From the file)
      #to do this each eteration
          move $t8,$zero
          move $t2,$zero
         lb $a0,buffer
         #beq $a0,'\n',main
         beqz $t3,main
          j read_loop
          
Strrtoint:
   lb $t3, buffer       #the character 
   beq $t3,':',LoadFromBuffer   #for two digits number check
   addiu $t3, $t3, -48
   mul $t9, $t9, 10 # t9 --> 0  1 * 10 -->10 
   addu $t9, $t9, $t3 # 0 + 1  //t9 ? 1 ?? int  
   addiu $t7,$t7,1
   j read_loop 
Strrtooint:
      lb $t3,buffer
      addiu $t3, $t3, -48
      mul $t8, $t8, 10 # t9 --> 0  1 * 10 -->10 
      addu $t8, $t8, $t3 # 0 + 1  //t9 ? 1 ?? int  
      addiu $t7,$t7,1
      j read_loop
thiisdayDoesNotExis:
      beq $t9,$t1,Proocess
      li $v0, 4
      la $a0, message_dayDoesNotExist
      syscall
      li $v0, 16
      move $a0, $s0
      syscall
      j main
      
 #--------------------------Write ro File After remove appointment-------------------------
writeAfterRemove:

jal openFileToWrite2
    li $v0, 15
move $a0, $s0
la $a1, buffer2
move $a2,$t7
syscall
li $v0, 15
move $a0, $s0
la $a1, buffer3
move $a2,$t0
syscall
j main
#-------------------------exit-------------------------------
exit:
    # Exit the program
    li $v0, 10
    syscall
    
    
    
    
    
   

   
 

