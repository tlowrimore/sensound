# Randomly generates input values.  This is useful for development without
# a sensor
#NoteEmitter.start(:generate)

# Uses an IR sensor to generate input values
NoteEmitter.start(:read, '/dev/cu.usbmodem1411')
