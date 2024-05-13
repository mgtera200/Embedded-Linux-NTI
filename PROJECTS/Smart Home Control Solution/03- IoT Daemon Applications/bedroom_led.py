##
# Included Liberary
##
from google.cloud import firestore

#######################################

##
# Declared variables
##
light_1_curr = 0
light_1_prev = 0
light_2_curr = 0
light_2_prev = 0
light_3_curr = 0
light_3_prev = 0

lamp_1_curr = 0
lamp_1_prev = 0
lamp_2_curr = 0
lamp_2_prev = 0
lamp_3_curr = 0
lamp_3_prev = 0

##
# Initialize Firestore client
##
firestore_client = firestore.Client.from_service_account_json(
    "./autoome-b943c-ad9f82e890d2.json")


while (1):
    # Bedroom Ligt
    light_1_doc = firestore_client.collection("users") \
        .document("I3MMAZqPVkNcq3vmLtnzlZTPIoh2") \
        .collection("places") \
        .document("iRUPCuw9isLBrPXlNdmD") \
        .collection("rooms") \
        .document("53RVQ0PQpr6yle9o8Bih") \
        .collection("buttons") \
        .document("l4ATUD9Kd2I635F9Q80G")

    # Bathroom
    # light_2_doc = firestore_client.collection("users") \
    # .document("I3MMAZqPVkNcq3vmLtnzlZTPIoh2") \
    # .collection("places") \
    # .document("iRUPCuw9isLBrPXlNdmD") \
    # .collection("rooms") \
    # .document("6PORsoeVCIR4NyT3VP0M") \
    # .collection("buttons") \
    # .document("LQZC6OWLHWnqMtWNvL67")

    # Kitchen
    # light_3_doc = firestore_client.collection("users") \
    # .document("I3MMAZqPVkNcq3vmLtnzlZTPIoh2") \
    # .collection("places") \
    # .document("iRUPCuw9isLBrPXlNdmD") \
    # .collection("rooms") \
    # .document("mZ46hD8fdvxd8iFPK9DG") \
    # .collection("buttons") \
    # .document("h1u6Kphf4eJHCrvGqRsi")

    with open("light_1.txt", "r") as file:
        lamp_1_curr = file.read(1)
        print("File 1 : ", lamp_1_curr, " >  ", lamp_1_prev)

    # with open("light_2.txt", "r") as file:
    #     lamp_2_curr = file.read(1)
    #     print("File 2 : ", lamp_2_curr, " >  ", lamp_2_prev)

    with open("light_3.txt", "r") as file:
        lamp_3_curr = file.read(1)
        print("File 3 : ", lamp_3_curr, " >  ", lamp_3_prev)

    print(".......")

    # Get the document
    doc = light_1_doc.get()
    light_1_curr = doc.to_dict()
    light_1_curr = light_1_curr.get("boolVal")

    # doc = light_2_doc.get()
    # light_2_curr = doc.to_dict()
    # light_2_curr = light_2_curr.get("boolVal")

    # doc = light_3_doc.get()
    # light_3_curr = doc.to_dict()
    # light_3_curr = light_3_curr.get("boolVal")

    print("#########################")

    print("light_1 : ", light_1_curr, " >  ", light_1_prev)
    # print("light_2 : ", light_2_curr, " >  ", light_2_prev)
    # print("light_3 : ", light_3_curr, " >  ", light_3_prev)

    print("lamp_1 : ", lamp_1_curr, " >  ", lamp_1_prev)
    # print("lamp_2 : ", lamp_2_curr, " >  ", lamp_2_prev)
    # print("lamp_3 : ", lamp_3_curr, " >  ", lamp_3_prev)

    print("#########################")

    if ((light_1_curr != light_1_prev) and (lamp_1_curr == lamp_1_prev)):
        print("Light 1 : ", light_1_curr)
        with open("light_1.txt", "w") as file:
            file.write(str(light_1_curr))
        light_1_prev = light_1_curr
        lamp_1_curr = light_1_curr
        lamp_1_prev = lamp_1_curr
    elif ((lamp_1_prev != lamp_1_curr)):
        print("Lamp_1 : ", lamp_1_curr)
        light_1_doc.update({"boolVal": int(lamp_1_curr)})
        lamp_1_prev = lamp_1_curr
        light_1_curr = lamp_1_curr
        light_1_prev = light_1_curr

    # if ((light_2_curr != light_2_prev) and (lamp_2_curr == lamp_2_prev)):
    #     print("Light 2 : ", light_2_curr)
    #     with open("light_2.txt", "w") as file:
    #         file.write(str(light_2_curr))
    #     light_2_prev = light_2_curr
    #     lamp_2_curr = light_2_curr
    #     lamp_2_prev = lamp_2_curr
    # elif ((lamp_2_prev != lamp_2_curr)):
    #     print("Lamp_2 : ", lamp_2_curr)
    #     light_2_doc.update({"boolVal": int(lamp_2_curr)})
    #     lamp_2_prev = lamp_2_curr
    #     light_2_curr = lamp_2_curr
    #     light_2_prev = light_2_curr

    # if ((light_3_curr != light_3_prev) and (lamp_3_curr == lamp_3_prev)):
    #     print("Light 3 : ", light_3_curr)
    #     with open("light_3.txt", "w") as file:
    #         file.write(str(light_3_curr))
    #     light_3_prev = light_3_curr
    #     lamp_3_curr = light_3_curr
    #     lamp_3_prev = lamp_3_curr
    # elif ((lamp_3_prev != lamp_3_curr)):
    #     print("Lamp_3 : ", lamp_3_curr)
    #     light_3_doc.update({"boolVal": int(lamp_3_curr)})
    #     lamp_3_prev = lamp_3_curr
    #     light_3_curr = lamp_3_curr
    #     light_3_prev = light_3_curr

    # if ((light_1_curr != light_1_prev) and (lamp_1_curr == lamp_1_prev)):
    #     print("Light 1 : ", light_1_curr)
    #     with open("light_1.txt", "w") as file:
    #         file.write(str(light_1_curr))
    #     light_1_prev = light_1_curr
    #     lamp_1_curr = light_1_curr
    #     lamp_1_prev = lamp_1_curr
    # elif ((lamp_1_prev != lamp_1_curr) and (light_1_curr == light_1_prev)):
    #     print("Lamp_1 : ", lamp_1_curr)
    #     light_1_doc.update({"boolVal": int(lamp_1_curr)})
    #     lamp_1_prev = lamp_1_curr
    #     light_1_curr = lamp_1_curr
    #     light_1_prev = light_1_curr
    # elif ((lamp_1_prev != lamp_1_curr) and (light_1_curr != light_1_prev)):
    #     print("Lamp_1 : ", lamp_1_curr)
    #     light_1_doc.update({"boolVal": int(lamp_1_curr)})
    #     lamp_1_prev = lamp_1_curr
    #     light_1_curr = lamp_1_curr
    #     light_1_prev = light_1_curr

    # if (light_1_curr != light_1_prev):
    #     print("Light 1 : ", light_1_curr)
    #     with open("light_1.txt", "w") as file:
    #         file.write(str(light_1_curr))
    #     light_1_prev = light_1_curr
    #     lamp_1_curr = light_1_curr
    #     lamp_1_prev = lamp_1_curr

    # if (light_2_curr != light_2_prev):
    #     print("Light 2 : ", light_2_curr)
    #     with open("light_2.txt", "w") as file:
    #         file.write(str(light_2_curr))
    #     light_2_prev = light_2_curr
    #     lamp_2_curr = light_2_curr
    #     lamp_2_prev = lamp_2_curr

    # if (light_3_curr != light_3_prev):
    #     print("Light 3 : ", light_3_curr)
    #     print("Light 3 : ", light_2_curr)
    #     with open("light_3.txt", "w") as file:
    #         file.write(str(light_2_curr))
    #     light_3_prev = light_3_curr
    #     lamp_3_curr = light_3_curr
    #     lamp_3_prev = lamp_3_curr

    # if (lamp_1_curr != lamp_1_prev):
    #     print("Lamp_1 : ", lamp_1_curr)
    #     light_1_doc.update({"boolVal": int(lamp_1_curr)})
    #     lamp_1_prev = lamp_1_curr
    #     light_1_curr = lamp_1_curr
    #     light_1_prev = light_1_curr

    # if (lamp_2_curr != lamp_2_prev):
    #     print("Lamp_1 : ", lamp_2_curr)
    #     light_2_doc.update({"boolVal": int(lamp_2_curr)})
    #     lamp_2_prev = lamp_2_curr
    #     light_2_curr = lamp_2_curr
    #     light_2_prev = light_2_curr

    # if (lamp_3_curr != lamp_3_prev):
    #     print("Lamp_1 : ", lamp_3_curr)
    #     light_3_doc.update({"boolVal": int(lamp_3_curr)})
    #     lamp_3_prev = lamp_3_curr
    #     light_3_curr = lamp_3_curr
    #     light_3_prev = light_3_curr

    ###########

    # if (btn_1_curr != btn_1_prev):
    #     print("btn_1 : ", btn_1_curr)
    #     btn_1_prev = btn_1_curr
    #     light_1_doc.update({"boolVal": int(btn_1_curr)})
    #     light_1_curr = btn_1_curr
    #     light_1_prev = light_1_curr

    # if (btn_2_curr != btn_2_prev):
    #     print("btn_2 : ", btn_2_curr)
    #     btn_2_prev = btn_2_curr
    #     light_2_doc.update({"boolVal": int(btn_2_curr)})
    #     light_2_curr = btn_2_curr
    #     light_2_prev = light_2_curr

    # if (btn_3_curr != btn_3_prev):
    #     print("btn_3 : ", btn_3_curr)
    #     btn_3_prev = btn_3_curr
    #     light_3_doc.update({"boolVal": int(btn_3_curr)})
    #     light_3_curr = btn_3_curr
    #     light_3_prev = light_3_curr
