const router = require("express").Router();

const userController = require("../controller/userController");
const classroomController = require("../controller/classroomController");
const scheduleController = require("../controller/scheduleController");
const verifyJWT = require('../services/verifyJWT');
const totalController = require("../controller/totalController");

//User
router.post("/user", userController.createUser);
router.post("/user/login", userController.loginUser);
router.get("/user/", verifyJWT, userController.getAllUsers);
router.put("/upusers/:id", verifyJWT, userController.updateUser);
router.delete("/users/:id", verifyJWT,userController.deleteUser);
router.get("/user/:id", verifyJWT, userController.getUserById);

//Classroom
router.post("/classroom/", verifyJWT, classroomController.createClassroom);
router.get("/classroom/", verifyJWT, classroomController.getAllClassrooms);
router.get("/classroom/:number", verifyJWT, classroomController.getClassroomById);
router.put("/classroom/", verifyJWT, classroomController.updateClassroom);
router.delete("/classroom/:number", verifyJWT, classroomController.deleteClassroom);

//Schedule
router.post("/schedules/", verifyJWT, scheduleController.createSchedule);
router.get('/schedule/user/:id', scheduleController.getSchedulesByUser);
router.get("/schedule/", verifyJWT, scheduleController.getAllSchedules);
router.get("/disponibilidade/:fk_number/:date", verifyJWT, scheduleController.getHorariosDisponiveisPorSalaEData);
router.put("/schedules/", verifyJWT, scheduleController.updateSchedule);
router.delete("/schedules/:id", verifyJWT, scheduleController.deleteSchedule);

//total
router.post("/total/reservas/usuario/:id", verifyJWT, totalController.totalReservasUsuario);

module.exports = router;
