import tkinter as tk
import test_output
import multiprocessing as mp

APPLICATION_NAME = "ACMV Regulator"
BACKGROUND_COLOUR = "black"
TEXT_COLOUR = "white"


def updateArea1(value):
    if value > 29.5:
        output_label_area1.config(bg="red")
        area1.config(bg="red")
    elif value > 29.5:
        output_label_area1.config(bg="orange")
        area1.config(bg="orange")
    elif value > 29:
        output_label_area1.config(bg="yellow")
        area1.config(bg="yellow")
    elif value > 28.5:
        output_label_area1.config(bg="green")
        area1.config(bg="green")
    else:
        output_label_area1.config(bg="blue")
        area1.config(bg="blue")
    
    output_label_area1.config(
        text = (
            str(value)
        ).ljust(5,"0")
    )

def recieveOutput():
        all_output = child.recv()
        output_area1 = round(all_output[0],2)
        updateArea1(output_area1)
        Root.after(100, recieveOutput)


if __name__ == '__main__':

    Root = tk.Tk()
    Root.geometry("1000x800")
    Root.configure(bg=BACKGROUND_COLOUR)
    parent, child = mp.Pipe()
    process1 = mp.Process(target = test_output.output, args = (parent, ))      # Create a process for handling parent data
    process1.start()                    # Start the  parent process
        # print(child.recv())              # Display data received from parent (HELLO)

    application_name_label = tk.Label(
        Root,
        text=APPLICATION_NAME,
        bg=BACKGROUND_COLOUR,
        fg=TEXT_COLOUR,
        font=("Arial", 25)
    )

    application_name_label.place(
        relx = 0.5,
        rely = 0.02,
        anchor = 'center'
    )

    Root.update()
    area1 = tk.Canvas(
        Root,
        height=Root.winfo_screenheight()/3,
        width=Root.winfo_screenwidth()/4 ,
        highlightbackground="white",
        bg=BACKGROUND_COLOUR,
    )
    
    area1.place(
        relx = 0.1,
        rely = 0.1,
        anchor = 'nw'
    )

    
    output_label_area1 = tk.Label(
        area1,
        text="-",
        bg=BACKGROUND_COLOUR,
        fg=TEXT_COLOUR,
        font=("Arial", 25)
    )


    output_label_area1.place(
        relx = 0.99,
        rely = 0.99,
        anchor = 'se'
    )

    

    recieveOutput()
    Root.mainloop()
        