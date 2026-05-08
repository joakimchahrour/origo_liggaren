#import "styles.typ": *
#import "script.typ": *

#let sheet_url = "https://script.google.com/macros/s/AKfycbyVdopdd5Pho2CPhnxWjsYSVeDEMmFveDeNSxoP1IOYx1cLekvrzVrKwoMLGa2te0kg1w/exec"

#show: page_wrapper

#google_script(sheet_url)

// Warning Box
#html.elem("div", attrs: (style: "background: #FF0000; color: white; padding: 20px; border-radius: 10px; border: 5px solid #f1f505; max-width: 500px; margin: 0 auto 20px auto; font-family: sans-serif;"), [
  #html.elem("h2", [OBS!])
  *This is a test of a new system. If something happens we still need your information. So please, for legal reasons, fill in the physical book as well. Thank you!*
])

= Welcome to Origo
Hi! I am Origo Liggaren. I have left the physical world and transcended into digital land.

Thank you for working at Origo, you keep this place running! Please enter your information for the BGC below. 

// Main Form
#html.elem("div", attrs: (
  style: "background: #f5f5f5; padding: 20px; border-radius: 10px; border: 5px solid #ddd; max-width: 500px; margin: auto; font-family: sans-serif;"
), [
  #html.elem("h2", [Worker Time Portal])
  
  *Name:* #html.elem("input", attrs: (type: "text", id: "worker-name", style: input_style))
  
  *Barlag:* #html.elem("select", attrs: (id: "barlag", style: input_style), [
    #html.elem("option", attrs: (value: ""), "Select your Barlag")
    #html.elem("option", attrs: (value: "MhetAB"), "Barlag MHetAB")
    #html.elem("option", attrs: (value: "F"), "Barlag F")
    #html.elem("option", attrs: (value: "Kelix"), "Barlag Kelix")
    #html.elem("option", attrs: (value: "MEGABH"), "Barlag MEGA BH")
    #html.elem("option", attrs: (value: "#FEST"), "Barlag #Fest")
  ])
  
  *Date:* #html.elem("input", attrs: (type: "date", id: "work-date", style: input_style)) 
  
  *Start*: #html.elem("input", attrs: (type: "time", id: "start", onchange: "calculate()", style: "padding: 5px;")) 
  
  *End*: #html.elem("input", attrs: (type: "time", id: "end", onchange: "calculate()", style: "padding: 5px;"))
  
  #html.elem("p", attrs: (style: "font-size: 0.9em; color: #666; margin-top: 15px;"), [DON'T FORGET TO HIT THE SUBMIT BUTTON!])
  
  #html.elem("div", attrs: (style: "font-weight: bold; font-size: 1.2em; margin-bottom: 15px;"), [
    Total Duration: #html.elem("span", attrs: (id: "result"), [---])
  ])

  #html.elem("button", attrs: (
    onclick: "submitToGoogle()", 
    style: "background: #007bff; color: white; padding: 12px 20px; border: none; border-radius: 5px; cursor: pointer; width: 100%; font-weight: bold;"
  ), [Submit Hours])
  
  #html.elem("p", attrs: (id: "status", style: "text-align: center; margin-top: 10px; font-weight: bold;"), [])
])

= Origo Liggaren is open source!
If you are interested on how Origo liggaren is made or want to contribute please visit the GitHub repository: https://github.com/joakimchahrour/origo_liggaren. 
