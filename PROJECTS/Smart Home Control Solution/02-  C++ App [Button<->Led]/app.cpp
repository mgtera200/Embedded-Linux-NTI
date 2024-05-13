#include <fstream>
#include <iostream>
using namespace std;

#define WAIT_TICKS 1000000
#define DEBOUNCE_WAIT_TICKS 10

class Driver
{
private:
    string PATH ;
    fstream m_fd;

public:
    Driver(string path);
    void WriteFile(string message);
    string ReadFile();
};
Driver::Driver(string path)
{
    PATH=path;
}
void Driver::WriteFile(string message)
{
    m_fd.open(PATH, ios::out);
    m_fd.write(message.c_str(), message.size());
    m_fd.close();
}
string Driver::ReadFile()
{
    string result;
    m_fd.open(PATH);
    getline(m_fd, result);
    m_fd.close();
    return result;
}

int main()
{
    Driver btn0("/dev/BTN0");
    Driver led0("/dev/LED0");
    Driver btn1("/dev/BTN1");
    Driver led1("/dev/LED1");
    Driver btn2("/dev/BTN2");
    Driver led2("/dev/LED2");
    cout << "the application is Running ..." << endl;
    bool currState = false;
    int counter = 0;
    bool changed = false;
    while(1)
    {
        counter = 0;
        string input = btn0.ReadFile();

        while(input == "1" && counter < DEBOUNCE_WAIT_TICKS)
        {
            // cout << "counting: "<< counter << '\t' << input << endl;
            input = btn0.ReadFile();
            input = btn0.ReadFile();
            counter ++;
            cout << "counting: "<< counter << '\t' << input << endl;
        }

        if(input == "1" && counter >= DEBOUNCE_WAIT_TICKS)
        {
            // currState != currState;
            if(currState)
                currState = false;
            else
                currState = true;

            changed = true;
            cout << "changed currState to : "<< currState << endl;

            while(input == "1")
            {
                input = btn0.ReadFile();
                input = btn0.ReadFile();
            }
        }

        if(changed)
        {
            // cout << "writing"<< endl;
            switch(currState)
            {
                case false:
                    led0.WriteFile("0");
                    cout << "writing: 0"<< endl;
                    break;

                case true:
                    led0.WriteFile("1");
                    cout << "writing: 1"<< endl;
                    break;

                default:
                    led0.WriteFile("0");
                    break;
            }
            changed = false;
        }

        input = btn1.ReadFile();
        input = btn1.ReadFile();
        led1.WriteFile(input);

        input = btn2.ReadFile();
        input = btn2.ReadFile();
        led2.WriteFile(input);    

        cout << "running"<<endl;
        // led.WriteFile(input);
        for(int i = 0; i < WAIT_TICKS; i++){}        
    }
    return 0;
}