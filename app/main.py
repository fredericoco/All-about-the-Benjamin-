import subprocess
import tkinter as tk

SCRIPT_DIR = __file__.rsplit("/", 1)[0] if "/" in __file__ else "."


def run_processing():
    label["text"] = "running..."
    root.update_idletasks()
    result = subprocess.run(
        ["sh", f"{SCRIPT_DIR}/process.sh"], capture_output=True, text=True
    )
    label["text"] = result.stdout.strip() or "done"


root = tk.Tk()
root.title("Dockerized Tkinter App")
root.geometry("320x150")

label = tk.Label(root, text="Click to run processing", font=("Arial", 11), justify="left")
label.pack(pady=20)

tk.Button(root, text="Run", command=run_processing).pack()

root.mainloop()
