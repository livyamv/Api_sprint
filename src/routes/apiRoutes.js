const router = require("express").Router();

const userController = require("../controller/userController");
const classroomController = require("../controller/classroomController");
const scheduleController = require("../controller/scheduleController");

//User
router.post("/user/", userController.createUser);
router.post("/user/login", userController.loginUser);
router.get("/user/", userController.getAllUsers);
router.put("/user/:id", userController.updateUser);
router.delete("/user/:id", userController.deleteUser);

//Classroom
router.post("/classroom/", classroomController.createClassroom);
router.get("/classroom/", classroomController.getAllClassrooms);
router.get("/classroom/:number", classroomController.getClassroomById);
router.put("/classroom/", classroomController.updateClassroom);
router.delete("/classroom/:number", classroomController.deleteClassroom);

//Schedule
router.post("/schedule/", scheduleController.createSchedule);
router.get("/schedule/", scheduleController.getAllSchedules);
router.put("/schedule/:id", scheduleController.updateSchedule);
router.delete("/schedule/:id", scheduleController.deleteSchedule);

module.exports = router;
