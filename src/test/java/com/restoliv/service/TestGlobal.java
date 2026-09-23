package com.restoliv.service;

import com.restoliv.config.TestConnexion;
import com.restoliv.dao.TestDAO;

// Lance toutes les suites de tests du projet.
public class TestGlobal {

    public static void main(String[] args) throws Exception {
        System.out.println("========================================");
        System.out.println(" LANCEMENT DE LA BATTERIE DE TESTS");
        System.out.println("========================================");

        TestUtil.reinitialiserCompteurs();
        TestConnexion.main(args);
        TestDAO.main(args);
        TestService.main(args);
        TestPlatService.main(args);
        TestLivreurService.main(args);
        TestCommandeService.main(args);

        System.out.println("========================================");
        System.out.println(" RESULTAT GLOBAL : " + TestUtil.getReussites()
                + " OK, " + TestUtil.getEchecs() + " ECHEC");
        System.out.println("========================================");
    }
}