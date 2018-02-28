import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kopo.dao.BoardDAO;
import com.kopo.domain.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MemberDAOTest {

	@Inject
	private BoardDAO dao;
	
	@Test 
	public void testTime() throws Exception{
		//System.out.println(dao.getTime());
		
	}
	
	@Test
	public void testInsertMember() throws Exception{
		
		MemberVO vo = new MemberVO();
		vo.setUserid("user10");
		vo.setUserpw("user00");
		vo.setUsername("USER00");
		vo.setEmail("user00@email.com");
		
		//dao.insertMember(vo);
	}
}
