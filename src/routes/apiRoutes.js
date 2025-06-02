const router = require("express").Router();

const userController = require("../controller/userController");
const classroomController = require("../controller/classroomController");
const scheduleController = require("../controller/scheduleController");
const verifyJWT = require('../services/verifyJWT');

//User
router.post("/user", userController.createUser);
router.post("/user/login", userController.loginUser);
router.get("/user/", verifyJWT, userController.getAllUsers);
router.put("/user/", verifyJWT, userController.updateUser);
router.delete("/user/:id", verifyJWT,userController.deleteUser);
router.get("/user/:id", verifyJWT, userController.getUserById);

//Classroom
router.post("/classroom/", classroomController.createClassroom);
router.get("/classroom/", classroomController.getAllClassrooms);
router.get("/classroom/:number", classroomController.getClassroomById);
router.put("/classroom/", classroomController.updateClassroom);
router.delete("/classroom/:number", classroomController.deleteClassroom);

//Schedule
router.post("/schedules/", verifyJWT, scheduleController.createSchedule);
router.get("/schedule/", verifyJWT, scheduleController.getAllSchedules);
router.get("/disponibilidade/:fk_number/:date", verifyJWT, scheduleController.getHorariosDisponiveisPorSalaEData);
router.put("/schedule/", verifyJWT, scheduleController.updateSchedule);
router.delete("/schedule/:id", verifyJWT, scheduleController.deleteSchedule);
router.get("/schedule/user/:id", verifyJWT, scheduleController.getSchedulesByUser);

module.exports = router;
