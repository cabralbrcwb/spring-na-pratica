package br.com.vmtec.controller;

import br.com.vmtec.dto.UserRegistrationDto;
import br.com.vmtec.exception.UserAlreadyExistAuthenticationException;
import br.com.vmtec.model.User;
import br.com.vmtec.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping
    public ModelAndView listUsers(@RequestParam(name = "nome", required = false) String nome,
                                  @RequestParam(defaultValue = "0") int page,
                                  @RequestParam(defaultValue = "5") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<User> users = userService.findAll(nome, pageable);

        ModelAndView mv = new ModelAndView("list-users");
        mv.addObject("users", users);
        return mv;
    }

    @GetMapping("/edit")
    public ModelAndView showEditForm(@RequestParam("id") Integer id) {
        User user = userService.findById(id);

        UserRegistrationDto dto = new UserRegistrationDto();
        dto.setUserID(user.getId());
        dto.setName(user.getName());
        dto.setEmail(user.getEmail());


        ModelAndView mv = new ModelAndView("edit-user");
        mv.addObject("userForm", dto);
        return mv;
    }

    @PostMapping("/edit")
    public String processEditForm(@RequestParam("id") Integer id,
                                  @ModelAttribute("userForm") UserRegistrationDto userForm,
                                  RedirectAttributes redirectAttrs) {
        try {
            userService.updateUser(id, userForm);
            redirectAttrs.addFlashAttribute("successMessage", "Usuário atualizado com sucesso!");
            return "redirect:/users";
        } catch (UserAlreadyExistAuthenticationException e) {
            redirectAttrs.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/users/edit?id=" + id;
        }

    }
}
