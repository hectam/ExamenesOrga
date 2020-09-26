#include <iostream>
#include "easm.h"
#include "rlutil-master/rlutil.h"

#include <fstream>

#include <string>

std::string getFileContents (std::ifstream&); 

extern "C" ErrorCode handleSyscall(uint32_t *regs, void *mem, MemoryMap *mem_map)
{
    unsigned v0 = regs[Register::v0];

    switch (v0)
    {
        case 20:
        {
            int a0 = regs[Register::a0];
            int a1 = regs[Register::a1];
            regs[Register::v0] = a0 + a1;
            return ErrorCode::Ok;


            break;
        }
        case 21: // name print
        {  
            

             std::ifstream Reader ("title.txt");             //Open file
           
             std::string Art = getFileContents (Reader);       //Get file
            
             std::cout << Art << std::endl;               //Print it to the screen
           
             Reader.close();                           //Close file

            return ErrorCode::Ok;

            break;
             
        }
        case 22: // gotoxy
        {
            int a0 = regs[Register::a0];
            int a1 = regs[Register::a1];
            gotoxy(a0,a1);

            return ErrorCode::Ok;

            break;
        }
        case 23: // clear screan
        {
            rlutil::cls();

            return ErrorCode::Ok;

            break;
        }

        case 24:// Player movement
        {

            int a0_x = regs[Register::a0]; // s0 define el limite izquierdo, s1 derecho
            int a1_y = regs[Register::a1]; // s2 define el limite de arriba, s3 de abajo
            int a2_localize_screen = regs[Register::a2];
            


            int returned_Action= 10;

            int pos = regs[Register::s5];

            

           int key = rlutil::getkey();

            switch (key)
            {
            case 65:
                if(  a1_y > regs[Register::s2]){
                    
                        a1_y = a1_y - 2;
                    pos -= 10;
                }returned_Action = 4;
                
                break;
            
            case 66:
                if( a1_y < regs[Register::s3]){
                     
                        a1_y = a1_y + 2;
                   pos += 10;
                        
                }returned_Action = 4;
                
                break;

            case 67:
                
                if(a2_localize_screen == 2){
                    if(a0_x < regs[Register::s1]){
                        a0_x= a0_x + 4;
                        pos += 1;
                    }

                }returned_Action = 4;
                
                break;

            case 68:
                if(a2_localize_screen == 2){
                    if(a0_x > regs[Register::s0]){
                         a0_x= a0_x - 4;
                         pos -= 1;
                    }
                }
                returned_Action = 4;
                
                break;
            
            case 10:
                if(a2_localize_screen == 2){
                    returned_Action = 1; // FLAG
                }else
                {
                    returned_Action = 0;
                }
                
                
                break;
            case 32:
                if(a2_localize_screen == 2){
                    returned_Action = 2; // excavar
                }else
                {
                    returned_Action = 0;
                }
                
                break; 


            case 0:
                    if(a2_localize_screen == 2 )
                    returned_Action = 3;
                
                break;

            

            default:
                break;
            }

            regs[Register::v0] = a0_x;
            regs[Register::v1] = a1_y; 
            regs[Register::t2] = returned_Action;
            if(returned_Action == 4 && a2_localize_screen ==2){
            regs[Register::s5] = pos;
            }
            return ErrorCode::Ok;

            break;
        }

        case 25:
        {
            std::ifstream Reader ("parameters.txt");             //Open file
           
             std::string Art = getFileContents (Reader);       //Get file
            
             std::cout << Art << std::endl;               //Print it to the screen
           
             Reader.close();                           //Close file

            return ErrorCode::Ok;

            break;
            

        }

        case 26:
        {
            
            
            std::ifstream Reader ("bomb.txt");             //Open file
           
             std::string Art = getFileContents (Reader);       //Get file
            
             std::cout << Art << std::endl;               //Print it to the screen
           
             Reader.close();                           //Close file

            return ErrorCode::Ok;

            break;
        }
        
         case 27:
        {
            
            
            std::ifstream Reader ("bomb1.txt");             //Open file
           
             std::string Art = getFileContents (Reader);       //Get file
            
             std::cout << Art << std::endl;               //Print it to the screen
           
             Reader.close();                           //Close file

            return ErrorCode::Ok;

            break;
        }
         case 28:
        {
            
            
            std::ifstream Reader ("bomb2.txt");             //Open file
           
             std::string Art = getFileContents (Reader);       //Get file
            
             std::cout << Art << std::endl;               //Print it to the screen
           
             Reader.close();                           //Close file

            return ErrorCode::Ok;

            break;
        }

        case 29:
        {
            int a0 = 1000;
            rlutil::msleep(a0);
            srand((unsigned) time(0));
            int randomNumber;
            for (int index = 0; index < 10; index++) {
            randomNumber = (rand() % 99 ) + 0;
            }

            regs[Register::v0] = randomNumber;


            
            return ErrorCode::Ok;

            break;
        }
        case 30:
        {

            rlutil::setColor(4);

            return ErrorCode::Ok;

            break;
        }

        case 31:
        {

            rlutil::setColor(15);

            return ErrorCode::Ok;

            break;
        }

        case 32:
        {
             rlutil::setColor(3);
            std::ifstream Reader ("credit.txt");             //Open file
           
             std::string Art = getFileContents (Reader);       //Get file
            
             std::cout << Art << std::endl;               //Print it to the screen
           
             Reader.close();   
             
              rlutil::setColor(15);                        //Close file

            return ErrorCode::Ok;

            break;
        }

        case 33:
        {   

            int a0 = regs[Register::a0];
                std::string name;
                

            switch(a0)
            {
            case 1:
            {
            std::ifstream Reader ("bombl1.txt");             //Open file
           
             std::string Art = getFileContents (Reader);       //Get file
            
             std::cout << Art << std::endl;               //Print it to the screen
           
             Reader.close();
             break;
            } 
                

            case 2:
            {
            std::ifstream Reader ("bombl2.txt");             //Open file
           
             std::string Art = getFileContents (Reader);       //Get file
            
             std::cout << Art << std::endl;               //Print it to the screen
           
             Reader.close();
             break;
            } 
                
            case 3:
            {
            std::ifstream Reader ("bombl3.txt");             //Open file
           
             std::string Art = getFileContents (Reader);       //Get file
            
             std::cout << Art << std::endl;               //Print it to the screen
           
             Reader.close();

             break;
            } 
                
            
            default:
            {
                std::ifstream Reader ("bombu.txt");             //Open file
           
             std::string Art = getFileContents (Reader);       //Get file
            
             std::cout << Art << std::endl;               //Print it to the screen
           
             Reader.close(); 
             return ErrorCode::Ok;
                break;
            }


             }  
             
                                   //Close file

            return ErrorCode::Ok;

            break;
        }



        


        default:
            if (v0 > 20 && v0 <= 50)
            {
                std::cout << "Syscall: " << v0 << '\n' << std::flush;
                return ErrorCode::Ok;
            }
            else
            {
                return ErrorCode::SyscallsNotSupported;
            }
            break;
    }
}

std::string getFileContents (std::ifstream& File)
{
    std::string Lines = "";        //All lines
    
    if (File)                      //Check if everything is good
    {
	while (File.good ())
	{
        
	    std::string TempLine;                  //Temp line
	    std::getline (File , TempLine);        //Get temp line
        
	    TempLine += "\n";                      //Add newline character
	    
	    Lines += TempLine;  
                          //Add newline
	}
	return Lines;
    }
    else                           //Return error
    {
	return "ERROR File does not exist.";
    }
}