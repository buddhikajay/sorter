import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.event.*;

import java.net.URL;
import javax.imageio.ImageIO;

public class UI extends JComponent implements ChangeListener {
	JPanel gui;
	/**
	 * Displays the image.
	 */
	JLabel imageCanvas;
	Dimension size;
	double scale = 1.0;
	private BufferedImage image;
	JButton button1, button2;
	int i, l1;
	BufferedImage[] m;

	public UI() {
		size = new Dimension(10, 10);
		setBackground(Color.black);
	}

	public void setImage(Image image) {
		imageCanvas.setIcon(new ImageIcon(image));
	}

	public void initComponents() {
		if (gui == null) {
			gui = new JPanel(new BorderLayout());
			gui.setBorder(new EmptyBorder(5, 5, 5, 5));
			imageCanvas = new JLabel();
			JPanel imageCenter = new JPanel(new FlowLayout());
			imageCenter.add(imageCanvas);
			JScrollPane imageScroll = new JScrollPane(imageCenter);
			imageScroll.setPreferredSize(new Dimension(300, 100));
			gui.add(imageScroll, BorderLayout.CENTER);
			JPanel temp = new JPanel(new FlowLayout());

		}
	}

	public Container getGui() {
		initComponents();
		return gui;
	}

	public void stateChanged(ChangeEvent e) {
		int value = ((JSlider) e.getSource()).getValue();
		scale = value / 100.0;
		paintImage();
	}

	protected void paintImage() {
		int w = getWidth();
		int h = getHeight();
		int imageWidth = image.getWidth();
		int imageHeight = image.getHeight();
		BufferedImage bi = new BufferedImage((int) (imageWidth * scale), (int) (imageHeight * scale), image.getType());
		Graphics2D g2 = bi.createGraphics();
		g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		double x = (w - scale * imageWidth) / 2;
		double y = (h - scale * imageHeight) / 2;
		AffineTransform at = AffineTransform.getTranslateInstance(0, 0);
		at.scale(scale, scale);
		g2.drawRenderedImage(image, at);
		setImage(bi);
	}

	public Dimension getPreferredSize() {
		int w = (int) (scale * size.width);
		int h = (int) (scale * size.height);
		return new Dimension(w, h);
	}

	private JSlider getControl() {
		JSlider slider = new JSlider(JSlider.HORIZONTAL, 0, 500, 50);
		slider.setMajorTickSpacing(50);
		slider.setMinorTickSpacing(25);
		slider.setPaintTicks(true);
		slider.setPaintLabels(true);
		slider.addChangeListener(this);
		return slider;
	}

	public static void main(String[] args) {

		UI app = new UI();
		app.convertImages();
		app.m = app.getImages();

		JFrame frame = new JFrame();
		frame.setLayout(new FlowLayout());
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setContentPane(app.getGui());

		app.setImage(app.m[0]);
		app.image = app.m[0];
		app.i = 0;
		JPanel panel = new JPanel();
		panel.setLayout(new BoxLayout(panel, BoxLayout.X_AXIS));
		panel.setBackground(Color.white);
		panel.setBorder(BorderFactory.createLineBorder(Color.red));
		frame.add(panel, BorderLayout.NORTH);
		app.button1 = new JButton("Pre");
		app.button1.setPreferredSize(new Dimension(300, 25));
		app.button1.addActionListener(new ActionListener() {

			public void actionPerformed(ActionEvent e) {

				if (app.i == 0) {
					JOptionPane.showMessageDialog(null, "This is First Image");
				} else {
					app.i = app.i - 1;

					app.setImage(app.m[app.i]);
					app.image = app.m[app.i];
				}

			}
		});

		panel.add(app.button1);
		app.button2 = new JButton("Next");
		app.button2.setPreferredSize(new Dimension(300, 25));
		app.button2.addActionListener(new ActionListener() {

			public void actionPerformed(ActionEvent e) {

				if (app.i == app.m.length - 1) {
					JOptionPane.showMessageDialog(null, "This is LastImage");
				} else {
					app.i = app.i + 1;

					app.setImage(app.m[app.i]);
					app.image = app.m[app.i];
				}
			}

		});

		panel.add(app.button2, "East");
		frame.getContentPane().add(app.getControl(), "Last");
		frame.setSize(700, 500);
		frame.setLocation(200, 200);
		frame.setVisible(true);

	}

	public void convertImages() {
		int width = 0;
		int height = 0;
		try {
			BufferedReader inConf = new BufferedReader(new FileReader("config.txt"));
			height = Integer.valueOf(inConf.readLine().split(":")[1]);
			width = Integer.valueOf(inConf.readLine().split(":")[1]);
			inConf.close();
		} catch (IOException e) {
		}
		BufferedImage currentImage;
		final File dir = new File("inputfiles");
		File[] list = dir.listFiles();
		System.out.println(list.length);
		BufferedImage m;
		new File("outputImages").mkdir();
		for (int inc = 0; inc < list.length; inc++) {
			String name = "inputfiles/" + list[inc].getName();
			ReadYUYV ryuv = new ReadYUYV(width, height);
			ryuv.startReading(name);
			currentImage = ryuv.getImage();
			String path = "outputImages/" + inc + ".gif";
			try {
				
				ImageIO.write(currentImage, "GIF", new File(path));
			} catch (IOException e) {

				e.printStackTrace();
			}

		}

	}

	public BufferedImage[] getImages() {
		final File dir = new File("outputImages");
		File[] list = dir.listFiles();
		BufferedImage[] m = new BufferedImage[list.length];

		for (int inc = 0; inc < list.length; inc++) {
			String name = "outputImages/" + list[inc].getName();

			try {
				m[inc] = ImageIO.read(new File(name));
			} catch (IOException e) {

				e.printStackTrace();
			}

		}
		System.out.println(m);
		return m;

	}

}